var Stemmer = require("../src/stemmer.bs.js");

describe("Stemmer.r*", () => {
  const word = "противоестественном";

  it("finds rv correctly", () => {
    expect(Stemmer.rv(word)).toEqual("тивоестественном");
  });
});
