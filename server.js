var express = require("express");
var app = express();
const puppeteer = require("puppeteer");
const fs = require("fs");

const html = `<html>
<head>
  <meta charset="utf-8">
  <style>
    body { margin: 0; }
      </style>
</head>
<body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r125/three.min.js" integrity="sha512-XI02ivhfmEfnk8CEEnJ92ZS6hOqWoWMKF6pxF/tC/DXBVxDXgs2Kmlc9CHA0Aw2dX03nrr8vF54Z6Mqlkuabkw==" crossorigin="anonymous"></script>
</body>
</html>`;

// respond with "hello world" when a GET request is made to the homepage
app.get("/", function (req, res) {
  (async () => {
    const browser = await puppeteer.launch();
    const page = await browser.newPage();
    await page.setContent(html);
    await page.evaluate(() => {
      const scene = new THREE.Scene();
      const camera = new THREE.PerspectiveCamera(
        75,
        window.innerWidth / window.innerHeight,
        0.1,
        1000
      );

      const renderer = new THREE.WebGLRenderer({ antialias: true });
      renderer.setSize(window.innerWidth, window.innerHeight);
      document.body.appendChild(renderer.domElement);

      const geometry = new THREE.BoxGeometry();
      const material = new THREE.MeshBasicMaterial({ color: 0x00ff00 });
      const cube = new THREE.Mesh(geometry, material);
      scene.add(cube);

      camera.position.z = 5;

      renderer.render(scene, camera);
    });

    console.log("write example.png");
    await page.screenshot({ path: "example.png" });

    await browser.close();
  })();

  //const file = fs.createWriteStream("example.png");

  res.send("File created.");
});

var server = app.listen(8081, function () {
  var host = server.address().address;
  var port = server.address().port;
  console.log("Example app listening at http://%s:%s", host, port);
});
