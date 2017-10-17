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

describe("Stemmer endings", () => {
  it("correctly removes perfective gerund's ending", () => {
    expect(Stemmer.from_perfective_gerund("взяв")).toEqual(Stemmer.done("взя"));
    expect(Stemmer.from_perfective_gerund("взявши")).toEqual(Stemmer.done("взя"));
    expect(Stemmer.from_perfective_gerund("взявшись")).toEqual(Stemmer.done("взя"));
    expect(Stemmer.from_perfective_gerund("взевшись")).toEqual(Stemmer.toReplace("взевшись"));
  });

  /*
  it("correctly removes adjective's ending", () => {
    expect(Stemmer.from_adjective("красный")).toBe("красн");
  });

  it("correctly removes participle's ending", () => {
    expect(Stemmer.from_participle("кидаем")).toBe("кида");
    expect(Stemmer.from_participle("худющ")).toBe("худ");
  });

  it("correctly removes reflexive's ending", () => {
    expect(Stemmer.from_reflexive("слоняясь")).toBe("слоняя");
  });

  it("correctly removes verb ending", () => {
    expect(Stemmer.from_verb("сломаете")).toBe("слома");
    expect(Stemmer.from_verb("выпил")).toBe("вып");
  });

  it("correctly removes noun ending", () => {
    expect(Stemmer.from_noun("покров")).toBe("покр");
    expect(Stemmer.from_noun("гора")).toBe("гор");
  });

  it("correctly removes superlative ending", () => {
    expect(Stemmer.from_superlative("старейш")).toBe("стар");
    expect(Stemmer.from_superlative("старейше")).toBe("стар");
  });

  it("correctly removes derivational ending", () => {
    expect(Stemmer.from_derivational("неприятность")).toBe("неприятн");
  });
  */
});
