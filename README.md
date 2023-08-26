<!-- Allow this file to not have a first line heading -->
<!-- markdownlint-disable-file MD041 no-emphasis-as-heading -->

<!-- inline html -->
<!-- markdownlint-disable-file MD033 -->

<div align="center">

# `🌊 Flow`

**Flexbox layouting for Roblox and Lua**

</div>

## About

Flow aims to be a high-performance Flexbox layout engine that adheres closely to the Flexbox specification. It is based
on Meta's [Yoga](https://github.com/facebook/yoga) library. For more details, refer to the
[Acknowledgements](#acknowledgements) section.

## Testing

### Adding Tests

Flow generates many of its tests automatically from HTML fixtures. These fixtures describe the node structure and are
rendered in Chrome to get expected layout outcomes. To add new fixtures, place them in the `gentest/fixtures` directory.

```html
<div id="my_test" style="width: 100px; height: 100px; align-items: center;">
  <div style="width: 50px; height: 50px;"></div>
</div>
```

To generate new tests:

1. Navigate to the `gentest` directory and run `npm install` to set up the test generator.
2. Execute `node index.js` in the same directory.

### Running Tests

Roblox Studio is required to execute Flow's benchmarks unit tests. See
[this issue](https://github.com/grilme99/Flow/issues/3) for more details.

To run tests in Roblox Studio:

1. Use `just install-packages` to set up required packages.
2. Build the project via `rojo build --output Flow.rbxl`.
3. Open the generated Roblox file and toggle the `RunBench` or `RunTests` scripts as needed (found under
   `ServerScriptService`).
4. Run the game and the results will be printed to the output.

## Benchmarks

TODO: Add benchmarks here

## Acknowledgements

Flow is a Lua adaptation of [Typeflex](https://github.com/dead/typeflex), a Typescript port of Yoga. It also
incorporates some work by [Roblox](https://www.roblox.com/) for Flexbox exploration in Lua.

As time goes on, it's likely Flow will deviate from Typeflex and align more closely with upstream Yoga. See
[this issue](https://github.com/grilme99/Flow/issues/2) for more details.
