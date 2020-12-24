const YoloModule = require(__dirname + '/build/Release/nodeyolojs').Yolo;
const imagemagick = require('imagickal');

class Yolo {
  constructor(working_dir, dataset, configuration_file, weights) {
    this.yolo = new YoloModule(working_dir, dataset, configuration_file, weights);
  }

  detect(image_path) {
    return new Promise((resolve, reject) => {
      this.yolo.detect(image_path).then(detections => {
        resolve(detections);
      })
        .catch(error => {
          reject(error);
        });
    });
  }
}

module.exports = Yolo;
