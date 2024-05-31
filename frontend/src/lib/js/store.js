import { writable } from "svelte/store";

export const user = writable({
  userId: null,
  userName: "",
  email: "",
  firstName: "",
  lastName: "",
  dateOfBirth: 0,
  description: "",
  avatar: "",
  isAdmin: 0
});
export let queryStore = writable({});

export const articleInfo = writable({ articleId: null, path: "/article", onArticlePage: false });
