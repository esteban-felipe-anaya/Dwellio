/* eslint-disable */
// Dwellio mock REST API built on json-server (programmatic mode).
// Adds: auth endpoints, query translation (price/beds/bounds/sort),
// /listings/:id/similar, and favorites stored as a flat id list.
//
//   npm install   &&   npm start          -> http://localhost:3000

const jsonServer = require('json-server');
const path = require('path');

const server = jsonServer.create();
const router = jsonServer.router(path.join(__dirname, 'db.json'));
const db = router.db; // lowdb instance
const middlewares = jsonServer.defaults();

server.use(middlewares);
server.use(jsonServer.bodyParser);

const TOKEN = 'mock-jwt-token-dwellio';

function publicUser(u) {
  if (!u) return null;
  const { password, ...rest } = u;
  return rest;
}

// --- Auth --------------------------------------------------------------------
server.post('/auth/login', (req, res) => {
  const { email, password } = req.body || {};
  const user = db.get('users').find({ email }).value();
  if (!user || user.password !== password) {
    return res.status(401).json({ message: 'Invalid email or password' });
  }
  res.json({ token: TOKEN, user: publicUser(user) });
});

server.post('/auth/register', (req, res) => {
  const { name, email, password } = req.body || {};
  if (!email || !password) {
    return res.status(400).json({ message: 'Email and password are required' });
  }
  const existing = db.get('users').find({ email }).value();
  if (existing) {
    return res.status(409).json({ message: 'An account with that email already exists' });
  }
  const user = {
    id: 'usr_' + Date.now(),
    name: name || 'New User',
    email,
    phone: '',
    photo: 'https://i.pravatar.cc/300?img=15',
    password,
  };
  db.get('users').push(user).write();
  res.status(201).json({ token: TOKEN, user: publicUser(user) });
});

server.get('/auth/me', (req, res) => {
  const auth = req.headers.authorization || '';
  if (!auth.includes(TOKEN)) return res.status(401).json({ message: 'Unauthorized' });
  const user = db.get('users').first().value();
  res.json({ user: publicUser(user) });
});

// --- Listings: filtering, bounds, sort, pagination ---------------------------
server.get('/listings', (req, res) => {
  const q = req.query;
  let items = db.get('listings').value().slice();

  if (q.dealType) items = items.filter((l) => l.dealType === q.dealType);
  if (q.type) items = items.filter((l) => l.propertyType === q.type);
  if (q.q) {
    const needle = String(q.q).toLowerCase();
    items = items.filter(
      (l) =>
        l.title.toLowerCase().includes(needle) ||
        l.address.toLowerCase().includes(needle) ||
        (l.city || '').toLowerCase().includes(needle)
    );
  }
  if (q.minPrice) items = items.filter((l) => l.price >= Number(q.minPrice));
  if (q.maxPrice) items = items.filter((l) => l.price <= Number(q.maxPrice));
  if (q.beds) items = items.filter((l) => l.beds >= Number(q.beds));
  if (q.baths) items = items.filter((l) => l.baths >= Number(q.baths));
  if (q.minArea) items = items.filter((l) => l.areaSqm >= Number(q.minArea));
  if (q.featured) items = items.filter((l) => l.featured === (q.featured === 'true'));

  if (q.amenities) {
    const wanted = String(q.amenities).split(',').filter(Boolean);
    items = items.filter((l) => wanted.every((a) => l.amenities.includes(a)));
  }

  // Map-bounds search.
  if (q.swLat && q.swLng && q.neLat && q.neLng) {
    const swLat = Number(q.swLat), swLng = Number(q.swLng);
    const neLat = Number(q.neLat), neLng = Number(q.neLng);
    items = items.filter(
      (l) => l.lat >= swLat && l.lat <= neLat && l.lng >= swLng && l.lng <= neLng
    );
  }

  switch (q.sort) {
    case 'price_asc': items.sort((a, b) => a.price - b.price); break;
    case 'price_desc': items.sort((a, b) => b.price - a.price); break;
    case 'area_desc': items.sort((a, b) => b.areaSqm - a.areaSqm); break;
    case 'newest':
    default: items.sort((a, b) => new Date(b.listedAt) - new Date(a.listedAt));
  }

  const total = items.length;
  res.setHeader('X-Total-Count', total);
  res.setHeader('Access-Control-Expose-Headers', 'X-Total-Count');

  const page = Number(q._page) || 1;
  const limit = Number(q._limit) || total || 1;
  const start = (page - 1) * limit;
  res.json(items.slice(start, start + limit));
});

server.get('/listings/:id/similar', (req, res) => {
  const target = db.get('listings').find({ id: req.params.id }).value();
  if (!target) return res.status(404).json({ message: 'Listing not found' });
  const similar = db
    .get('listings')
    .value()
    .filter(
      (l) =>
        l.id !== target.id &&
        l.dealType === target.dealType &&
        l.propertyType === target.propertyType
    )
    .slice(0, 6);
  res.json(similar);
});

server.post('/listings', (req, res) => {
  const body = req.body || {};
  const listing = {
    ...body,
    id: 'lst_' + Date.now(),
    featured: false,
    listedAt: new Date().toISOString(),
  };
  db.get('listings').push(listing).write();
  res.status(201).json(listing);
});

// --- Favorites stored as a flat id list --------------------------------------
server.get('/favorites', (req, res) => {
  res.json(db.get('favorites').value());
});
server.post('/favorites', (req, res) => {
  const { listingId } = req.body || {};
  const list = db.get('favorites');
  if (!list.value().includes(listingId)) list.push(listingId).write();
  res.status(201).json({ listingId });
});
server.delete('/favorites/:listingId', (req, res) => {
  const id = req.params.listingId;
  db.set('favorites', db.get('favorites').value().filter((x) => x !== id)).write();
  res.json({ ok: true });
});

// --- Tours & inquiries -------------------------------------------------------
server.post('/tours', (req, res) => {
  const { listingId, date, slot } = req.body || {};
  const tour = { id: 'tour_' + Date.now(), listingId, date, slot, status: 'pending' };
  db.get('tours').push(tour).write();
  // Surface scheduled tours in My Inquiries.
  db.get('inquiries')
    .push({
      id: 'inq_' + Date.now(),
      listingId,
      type: 'tour',
      lastMessage: `Tour requested for ${date} (${slot}).`,
      status: 'pending',
      date: new Date().toISOString(),
      messages: [{ from: 'user', text: `Tour requested for ${date} (${slot}).`, at: new Date().toISOString() }],
    })
    .write();
  res.status(201).json(tour);
});

server.post('/inquiries', (req, res) => {
  const { listingId, message } = req.body || {};
  const inquiry = {
    id: 'inq_' + Date.now(),
    listingId,
    type: 'message',
    lastMessage: message,
    status: 'open',
    date: new Date().toISOString(),
    messages: [{ from: 'user', text: message, at: new Date().toISOString() }],
  };
  db.get('inquiries').push(inquiry).write();
  res.status(201).json(inquiry);
});

// --- Default json-server router for everything else --------------------------
server.use(router);

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
  console.log(`Dwellio mock API running at http://localhost:${PORT}`);
});
