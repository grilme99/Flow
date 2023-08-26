build:
    rojo build --output FlowExample.rbxl

watch:
    rojo serve

install-packages:
    wally install

    rojo sourcemap --output sourcemap.json
    wally-package-types --sourcemap sourcemap.json packages/
