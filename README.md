## Sqids Playground for Delphi

[![Sqids Screen Shot][product-screenshot]][sqids-url]

[Sqids](https://sqids.org) (_pronounced "squids"_) is a small library that lets you **generate unique IDs from numbers**. It's good for link shortening, fast & URL-safe ID generation and decoding back into numbers for quicker database lookups.

Features:

- **Encode multiple numbers** - generate short IDs from one or several non-negative numbers
- **Quick decoding** - easily decode IDs back into numbers
- **Unique IDs** - generate unique IDs by shuffling the alphabet once
- **ID padding** - provide minimum length to make IDs more uniform
- **URL safe** - auto-generated IDs do not contain common profanity
- **Randomized output** - Sequential input provides nonconsecutive IDs
- **Many implementations** - Support for [40+ programming languages](https://sqids.org/)

## Use-cases

✅ Good for:

- Generating IDs for public URLs (eg: link shortening)
- Generating IDs for internal systems (eg: event tracking)
- Decoding for quicker database lookups (eg: by primary keys)

❌ Not good for:

- Sensitive data (this is not an encryption library)
- User IDs (can be decoded revealing user count)

## About this playground

In this FireMonkey project, you can play around with multiple parameters available and see the results in real-time. The default _Results_ tab creates 1000 rows in a MemTable and you can see how fast is to encode those live. There are two extra tabs available to customise what you want to encode and decode based on the chosen alphabet and length. Press the buttons and have fun!

## Sqids Code examples

```pascal
  var sqids := TSqidsEncoding.Create;
  var id := sqids.Encode([1, 2, 3]); // "86Rf07"
  var numbers := sqids.Decode(id); // [1, 2, 3]
```

> **Note**
> 🚧 Because of the algorithm's design, **multiple IDs can decode back into the same sequence of numbers**. If it's important to your design that IDs are canonical, you have to manually re-encode decoded numbers and check that the generated ID matches.

Randomize IDs by providing a custom alphabet and enforce a _minimum_ length for IDs:

```pascal
  var length := 10;
  var alphabet := 'JXx6Ue7jLqBk9cZmwA2szgdYNRP4lhOErDvQF1GTVIM3fao5t8WuSb0HyipKnC';
  var sqids := TSqidsEncoding.Create(alphabet, length);
  var id := sqids.Encode([1, 2, 3]); // "PtpDtXxiCD"
  var numbers := sqids.Decode(id); // [1, 2, 3]
```

## Prerequisites

For compiling this project you will need:

- Delphi 12 Athens+

#### Clone the repo

```sh
git clone https://github.com/azapater/sqids-playground.git
```

## Contact

- Twitter - [@antoniozapater](https://x.com/antoniozapater)
- LinkedIn - [@azapater](https://www.linkedin.com/in/azapater)

Repo Link: [https://github.com/azapater/sqids-playground](https://github.com/azapater/sqids-playground)

<!-- ACKNOWLEDGMENTS -->

[sqids-url]: https://sqids.org
[product-screenshot]: https://i0.wp.com/blogs.embarcadero.com/wp-content/uploads/2023/12/SqidsPlayground_9pWi0EVUWI-1482109.png?w=604&ssl=1
[code-button]: https://img.shields.io/badge/%3C%3E_code-darkgreen
