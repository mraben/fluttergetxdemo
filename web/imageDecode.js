//图片/视频解密 并渲染
 function downLoad (url, type) {
  return new Promise(async (resolve, reject) => {
    let data = "";
    try {
      let response = await fetch(url);
      data = await response.blob();
    } catch (e) { }

    if (!data) return
     console.log('dd',data);
    let metadata = {}
    type === 'video' ? metadata = {
      type: 'video/mp4'
    } : metadata = {
      type: 'image/jpeg'
    };
    let filename = "";
    type === 'video' ? filename = "test.mp4" : filename = "test.jpg"
    let file = new File([data], filename, metadata);
    let fileReader = new FileReader();
    fileReader.readAsArrayBuffer(file);
    fileReader.onload = function (ev) {
      const array = new Uint8Array(ev.target.result);
      const fileByteArray = [];
      for (let i = 0; i < array.length; i++) {
        fileByteArray.push(array[i]);
      }

      //byte->blobUrl
      //密匙Int16Array 为16位数组
      const keys = stringToArrayBuffer("qtutca95wuu5qk8r");
       console.log('keys',keys);
       console.log('bytes1',new Uint8Array(fileByteArray));
//      const bytes = new Uint8Array(fileByteArray.splice(16)) //加密密钥解码之后为前16位所以删除掉前16位byte之后即为内容
       const bytes = new Uint8Array(fileByteArray) //加密密钥解码之后为前16位所以删除掉前16位byte之后即为内容
      // console.log('bytes',bytes);
      const blob = new Blob([bytes], metadata)
      let blobUrl = (window.URL || window.webkitURL).createObjectURL(blob)
      // let base64Url =  fileReader.readAsDataURL(blob);
      // console.log('base64Url',base64Url);
      // this.$refs[dom].src= blobUrl
      // console.log('blobUrl',blobUrl,dom);

//      if (dom) dom.src = blobUrl
//      if (type === 'video') {
//        if (dom && blobUrl) {
//          dom.play();
//        } else {
//          setTimeout(() => {
//            dom.onloadeddata = (() => {
//              dom.play();
//            })
//          }, 50)
//        }
//      }

      if (blobUrl) {
        resolve(blobUrl)
      } else reject(false)

    }
  })
}

function stringToArrayBuffer(str) {
  var buf = new ArrayBuffer(str.length * 2); // 每个字符占用2个字节
  var bufView = new Uint16Array(buf);
  for (var i = 0, strLen = str.length; i < strLen; i++) {
    bufView[i] = str.charCodeAt(i);
  }
  let Int16Arrays = new Int16Array(buf)
  let bytes = []
  for (let i in Int16Arrays) {
    bytes.push(Int16Arrays[i])
  }
  return bytes;
}

function decryptImage(url,asekey) {
  return new Promise((resolve) => {
  //const url = 'http://www.m24ilhko.xyz/storage/website/img/20230831/NYIVNcK0tTIMx2F0.jpg';
  const decryptionKey = asekey; // 替换为你自己的密钥

  const xhr = new XMLHttpRequest();
  xhr.open('GET', url, true);
  xhr.responseType = 'arraybuffer';

  xhr.onload = function () {
      const encryptedData = new Uint8Array(xhr.response);
      const decryptedData = CryptoJS.AES.decrypt(
          { ciphertext: CryptoJS.lib.WordArray.create(encryptedData) },
          CryptoJS.enc.Utf8.parse(decryptionKey),
          {
              mode: CryptoJS.mode.ECB,
              padding: CryptoJS.pad.Pkcs7,
              iv: '',
              keySize: 128,
          }
      );
      // const decryptedArrayBuffer = decryptedData.toString(CryptoJS.enc.Latin1);
      // 将加密后的数据转换成 Base64
      const base64Cipher = decryptedData.toString(CryptoJS.enc.Base64);
      // // 例如：将imageUrl绑定到图像元素的src属性

//      let imgSrc = "data:image/png;base64," + base64Cipher
       let imgSrc =  base64Cipher
      resolve(imgSrc)
  };

  xhr.send();
})
}

function saveBase64Image(base64String, fileName) {
console.log('base64 img:' + base64String);
var link = document.createElement('a');
  link.href = base64String;
  link.download = fileName;
  link.click();
//  var byteCharacters = atob(base64String);
//
//  var byteNumbers = new Array(byteCharacters.length);
//  for (var i = 0; i < byteCharacters.length; i++) {
//    byteNumbers[i] = byteCharacters.charCodeAt(i);
//  }
//  var byteArray = new Uint8Array(byteNumbers);
//  var blob = new Blob([byteArray], { type: 'image/png' });
//
//  var xhr = new XMLHttpRequest();
//  xhr.onreadystatechange = function() {
//    if (xhr.readyState === 4 && xhr.status === 200) {
//      console.log('Image saved successfully!');
//    }
//  };
//  xhr.open('POST', 'save_image.php', true);
//  xhr.setRequestHeader('Content-Type', 'application/octet-stream');
//  xhr.setRequestHeader('X-File-Name', fileName);
//  xhr.send(blob);
}

