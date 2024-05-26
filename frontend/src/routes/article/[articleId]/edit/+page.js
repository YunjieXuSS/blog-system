// pre-load article data
export async function load({ parent ,params}) {
  console.log("route", params)
    console.log("loading article data...");
    const parentData = await parent();
    console.log("sdasdaskjdsadjalkjdlsakjdlakkjdaslkdjlkasjdlsakdjx",parentData);
  const article = parentData.article;

  return {article};
}
