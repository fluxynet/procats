CREATE TABLE proverbs (
	id UUID PRIMARY KEY,
	proverb TEXT,
	url TEXT
); 


INSERT INTO proverbs (id, proverb, url) VALUES ('abdff747-28be-4be2-b847-24d43642f325', 'Don''t communicate by sharing memory, share memory by communicating.', 'https://www.youtube.com/watch?v=PAAkCSZUG1c&t=2m48s');
INSERT INTO proverbs (id, proverb, url) VALUES ('aad2a2cb-80df-4b64-b714-ade891097245', 'Concurrency is not parallelism.', 'https://www.youtube.com/watch?v=PAAkCSZUG1c&t=3m42s');
INSERT INTO proverbs (id, proverb, url) VALUES ('82a3f3db-064b-4011-b9a1-f63dc2a35c03', 'Channels orchestrate; mutexes serialize.', 'https://www.youtube.com/watch?v=PAAkCSZUG1c&t=4m20s');
INSERT INTO proverbs (id, proverb, url) VALUES ('efd01ade-fe69-40d2-af5e-1c8397ac6367', 'The bigger the interface, the weaker the abstraction.', 'https://www.youtube.com/watch?v=PAAkCSZUG1c&t=5m17s');
INSERT INTO proverbs (id, proverb, url) VALUES ('5ccbda97-10fc-4358-a630-188f9efc0595', 'Make the zero value useful.', 'https://www.youtube.com/watch?v=PAAkCSZUG1c&t=6m25s');
INSERT INTO proverbs (id, proverb, url) VALUES ('9042e2d3-ad0c-4032-98a1-35310316dece', 'interface{} says nothing.', 'https://www.youtube.com/watch?v=PAAkCSZUG1c&t=7m36s');
INSERT INTO proverbs (id, proverb, url) VALUES ('9ff7fc2f-51dc-425e-8f2f-3541e6f3646c', 'Gofmt''s style is no one''s favorite, yet gofmt is everyone''s favorite.', 'https://www.youtube.com/watch?v=PAAkCSZUG1c&t=8m43s');
INSERT INTO proverbs (id, proverb, url) VALUES ('2f6e1fbd-c6fd-4b35-96c1-38fe1308d4b0', 'A little copying is better than a little dependency.', 'https://www.youtube.com/watch?v=PAAkCSZUG1c&t=9m28s');
INSERT INTO proverbs (id, proverb, url) VALUES ('b7b47159-dd22-44f3-8a2a-fe8d7d6c382d', 'Syscall must always be guarded with build tags.', 'https://www.youtube.com/watch?v=PAAkCSZUG1c&t=11m10s');
INSERT INTO proverbs (id, proverb, url) VALUES ('164c2b5f-50ea-4133-b9a3-6ac9b4d2c4dc', 'Cgo must always be guarded with build tags.', 'https://www.youtube.com/watch?v=PAAkCSZUG1c&t=11m53s');
INSERT INTO proverbs (id, proverb, url) VALUES ('bc6afcf4-030f-47ca-a28a-06883ddccd20', 'Cgo is not Go.', 'https://www.youtube.com/watch?v=PAAkCSZUG1c&t=12m37s');
INSERT INTO proverbs (id, proverb, url) VALUES ('8c07585e-2878-4a10-a969-06fd52c0924b', 'With the unsafe package there are no guarantees.', 'https://www.youtube.com/watch?v=PAAkCSZUG1c&t=13m49s');
INSERT INTO proverbs (id, proverb, url) VALUES ('7bdb77fc-0660-4ca6-bf8d-29d9638fbb58', 'Clear is better than clever.', 'https://www.youtube.com/watch?v=PAAkCSZUG1c&t=14m35s');
INSERT INTO proverbs (id, proverb, url) VALUES ('635d249d-989b-4274-8bfd-49b0b6f8d803', 'Reflection is never clear.', 'https://www.youtube.com/watch?v=PAAkCSZUG1c&t=15m22s');
INSERT INTO proverbs (id, proverb, url) VALUES ('622e7038-07d1-4c1f-aa1c-a0d376128b40', 'Errors are values.', 'https://www.youtube.com/watch?v=PAAkCSZUG1c&t=16m13s');
INSERT INTO proverbs (id, proverb, url) VALUES ('8cbcea68-8efc-4745-a7a9-73651f6e67a6', 'Don''t just check errors, handle them gracefully.', 'https://www.youtube.com/watch?v=PAAkCSZUG1c&t=17m25s');
INSERT INTO proverbs (id, proverb, url) VALUES ('a8d13c08-854e-4031-a6d1-5ca55124d72e', 'Design the architecture, name the components, document the details.', 'https://www.youtube.com/watch?v=PAAkCSZUG1c&t=18m09s');
INSERT INTO proverbs (id, proverb, url) VALUES ('015f7796-dfb2-47cf-aa01-21a97e7541e2', 'Documentation is for users.', 'https://www.youtube.com/watch?v=PAAkCSZUG1c&t=19m07s');
INSERT INTO proverbs (id, proverb, url) VALUES ('d25df4e4-ade9-4dd3-b2f6-e222e4d11824', 'Don''t panic.', 'https://github.com/golang/go/wiki/CodeReviewComments#dont-panic');

CREATE TABLE stats (
	id UUID PRIMARY KEY,
	url TEXT,
	visits INTEGER
);

INSERT INTO stats (id, url, visits) VALUES ('3b2cbc38-a4bb-4359-afa0-38650d4d564f', '/', 0);