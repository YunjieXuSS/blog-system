import { ARTICLES_URL, BASE_URL } from "$lib/js/apiUrls.js";

export async function postComment({ content, parentId, articleId }) {
  const res = await fetch(`${ARTICLES_URL}/${articleId}/comment`, {
    method: "post",
    credentials: "include",
    body: JSON.stringify({
      content: content,
      parentCommentId: parentId
    }),
    headers: {
      "Content-Type": "application/json"
    }
  });
  if (res.status >= 400) {
    throw Error("Failed to post this comment.");
  }
  const data = await res.json();
  return data;
}

export async function deleteComment({ commentId }) {
  const res = await fetch(`${BASE_URL}/comments/${commentId}`, {
    method: "delete",
    credentials: "include"
  });
  if (res.status >= 400) {
    throw Error("Failed to delete this comment.");
  }
}

export async function getComments({ articleId }) {
  const res = await fetch(`${ARTICLES_URL}/${articleId}/comments`);
  if (res.status !== 200) throw Error("Failed to get the comment list.");
  const comments = await res.json();
  return comments;
}
