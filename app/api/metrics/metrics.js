import client from 'prom-client';

const histogram = new client.Histogram({
  name: 'http_request_duration_ms',
  help: 'Duration of HTTP requests in ms',
  labelNames: ['method', 'route', 'status'],
  buckets: [50, 100, 200, 500, 1000],
});

export default async function handler(req, res) {
  histogram.observe({ method: req.method, route: req.url, status: 200 }, Math.random() * 500);
  res.setHeader('Content-Type', client.register.contentType);
  res.end(await client.register.metrics());
}
