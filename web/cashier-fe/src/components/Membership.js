import { useZxing } from "react-zxing";
import { useState } from "react";
// import { useNavigate } from "react-router-dom";

export const MembershipScanner = () => {
    // const navigate = useNavigate();
    const [id, setId] = useState("");
    const { ref } = useZxing({
      onDecodeResult(decodedResult) {
        console.log(decodedResult)
        setId(decodedResult.text);
        // POST to Spring backend the ID to add
        // fetch('/purchase/pay/' + decodedResult, {method: 'POST'})
        //   .then(response => response.json())
        //   .catch(error => console.error('Error posting barcode', error))
        //  .then(navigate('/'))
      }
    });
  
    return (
      <>
        <video style={{width: "600px", height: "400px"}} ref={ref} />
        <h2>{id}</h2>
      </>
    );
  };