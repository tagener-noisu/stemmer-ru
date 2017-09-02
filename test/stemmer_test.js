var Stemmer = require("../src/stemmer.bs.js");

describe("Stemmer.r*", () => {
  const word = "противоестественном";

  it("finds rv correctly", () => {
    expect(Stemmer.rv(word)).toEqual("тивоестественном");
  });

  it("finds r1 correctly", () => {
    expect(Stemmer.r1(word)).toEqual("ивоестественном");
  });

  it("finds r2 correctly", () => {
    expect(Stemmer.r2(word)).toEqual("оестественном");
  });
});
