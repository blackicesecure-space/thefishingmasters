"use client";

import { ApolloClient, InMemoryCache, ApolloProvider } from "@apollo/client";
import { useMemo } from "react";

function createApolloClient() {
  return new ApolloClient({
    uri: process.env.NEXT_PUBLIC_GRAPHQL_URL ?? "http://localhost:4000",
    cache: new InMemoryCache(),
    defaultOptions: {
      query: { fetchPolicy: "network-only" },
    },
  });
}

export function ApolloWrapper({ children }: { children: React.ReactNode }) {
  const client = useMemo(() => createApolloClient(), []);
  return <ApolloProvider client={client}>{children}</ApolloProvider>;
}
