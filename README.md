# Convolutional Pose Machines
Shih-En Wei, Varun Ramakrishna, Takeo Kanade, Yaser Sheikh, "[Convolutional pose machines](http://arxiv.org/abs/1602.00134)", CVPR 2016.

Contact: shihenw@cmu.edu.

## Before Everything
- Watch some [videos](https://www.youtube.com/playlist?list=PLNh5A7HtLRcpsMfvyG0DED-Dr4zW5Lpcg).
- Install [Caffe](http://caffe.berkeleyvision.org/). If you are interested in training this model on your own machines, consider using [our version](https://github.com/shihenw/caffe) with a data layer performing online augmentation. Make sure you have done `make matcaffe` and `make pycaffe`.
- Copy `caffePath.cfg.example` to `caffePath.cfg` and set your own path in it.

## Testing
- Run `get_model.sh` to retreive trained models from our web server.
- 1. `CPM_demo.m`: Put the testing image into `sample_image` then run it! You can select models (we provided 4) or other parameters in `config.m`. If you just want to try our best-scoring model, leave them default.
- 2. `CPM_benchmark.m`: Run the model on test benchmark and see the scores. Prediction files will be saved in `testing/predicts`.

## Training:
- Run `get_data.sh` to get datasets including [FLIC Dataset](http://vision.grasp.upenn.edu/cgi-bin/index.php?n=VideoLearning.FLIC), [LEEDS Sport Dataset](http://www.comp.leeds.ac.uk/mat4saj/lsp.html) and its [extended training set](http://www.comp.leeds.ac.uk/mat4saj/lspet.html), and [MPII Dataset](http://human-pose.mpi-inf.mpg.de/).
- Coming soon
