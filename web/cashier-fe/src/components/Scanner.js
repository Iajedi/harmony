import { useZxing } from "react-zxing";
import { useNavigate } from "react-router-dom";

export const BarcodeScanner = () => {
    const navigate = useNavigate();
    const { ref } = useZxing({
      onDecodeResult(decodedResult) {
        // POST to Spring backend the ID to add
        fetch('/purchase/' + decodedResult, {method: 'POST'})
          .then(response => response.json())
          .catch(error => console.error('Error posting barcode', error))
         .then(navigate('/purchase'))
      }
    });
  
    return (
      <>
        <video style={{width: "600px", height: "400px"}} ref={ref} />
      </>
    );
  };