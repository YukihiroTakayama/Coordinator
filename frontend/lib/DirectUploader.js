import { DirectUpload } from "@rails/activestorage"

class DirectUploader {
  constructor(file, url, onProgressCallback) {
    this.file = file
    this.url = url
    this.onProgressCallback = onProgressCallback
    this.directUpload = new DirectUpload(this.file, this.url, this)
  }
  upload(onErrorCallBack, onSuccessCallback) {
    this.directUpload.create((error, blob) => {
      if (error) {
        onErrorCallBack(error, this)
      } else {
        onSuccessCallback(blob, this)
      }
    })
  }
  directUploadWillStoreFileWithXHR(request) {
    request.upload.addEventListener("progress", event => this.directUploadDidProgress(event))
  }

  directUploadDidProgress(event) {
    this.onProgressCallback(event, this)
  }
}

export default DirectUploader