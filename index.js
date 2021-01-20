const express = require("express");
const { postgraphile } = require("postgraphile");

const postgraphileOptions = {
  pgSettings: (req) => {
    const settings = {};
    settings["role"] = "issue1420_role";
    settings["user.sub"] = "123123123213123";
    settings["user.firstname"] = "123123123213123";
    settings["user.lastname"] = "123123123213123";
    return settings;
  },
  graphiql: true,
  enhanceGraphiql: true,
  allowExplain: true,
};

const postgraphileMiddleware = postgraphile(
  "postgres:///issue1420",
  "app_public",
  postgraphileOptions
);

const app = express();
app.use(postgraphileMiddleware);
const port = 5000;
app.listen(port, () => {
  console.log(`Pricing service listening on http://localhost:${port}/graphiql`);
});
