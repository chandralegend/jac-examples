import:py from ultralytics, YOLO;
import:py numpy as np;
import:py from ultralytics.engine.results, Results as YOLOResult;

obj Result {
    has labels: set[str] = set();
    has detections: list[Detection] = [];
}

obj Detection {
    has label: str,
        confidence: float,
        box: Box;
}

obj Box {
    has x: float, y: float, w: float, h: float;
}

obj ObjectDetector {
    has model: YOLO = YOLO("yolov10n.pt", verbose=False);
    has fps: int = 2;

    can predict(img: np.ndarray | str) -> Result {
        result = self.model(img);
        result = self.process_result(result);
        return result;
    }

    can process_result(yolo_result: YOLOResults) -> Result {
        yolo_result = yolo_result[0];
        yolo_labels = yolo_result.names;
        result = Result();
        for box in yolo_result.boxes {
            label = yolo_labels[int(box.cls)];
            confidence = float(box.conf);
            (x, y, w, h) = box.xywhn.tolist()[0];
            result.labels.add(label);
            result.detections.append(Detection(label, confidence, Box(x, y, w, h)));
        }
        return result;
    }
}

with entry {
    object_detector = ObjectDetector();
    print(object_detector.predict("tunnel-7826204_640.jpg"));
}
