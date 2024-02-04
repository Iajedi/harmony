import { useZxing } from "react-zxing";
// import { useNavigate } from "react-router-dom";

export const MembershipScanner = () => {
  // const navigate = useNavigate();
  const { ref } = useZxing({
    onDecodeResult(decodedResult) {
      console.log(decodedResult)
      // POST to Spring backend the ID to add
      // fetch('/purchase/pay/' + decodedResult, {method: 'POST'})
      //   .then(response => response.json())
      //   .catch(error => console.error('Error posting barcode', error))
      //  .then(navigate('/'))
    }
  });

  return (
    <>
      <video style={{ width: "600px", height: "400px" }} ref={ref} />
    </>
  );
};