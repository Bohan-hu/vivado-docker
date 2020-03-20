# vivado-docker

Vivado installed into a docker image for INGInious Autograder used in HITSZ.
See document at https://inginious.readthedocs.io/en/v0.6/teacher_doc/create_container.html

## Build instructions

1. Copy the Vivado extracted installation file folder `Xilinx_Vivado_SDK_2018.3_1207_2324` to this folder.
2. Potentialy modify the `install_config.txt` to change the install options.
3. Build the image (will take about 30 minutes) passing in a build arg
    ```shell
    docker build --build-arg VIVADO_VERSION=2018.3 --build-arg VIVADO_SRC_DICT=Xilinx_Vivado_SDK_2018.3_1207_2324 -t vivado:2018.3 .
    ```

## Running

```shell
docker run -ti --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix vivado:2018.3
```
