import { useZxing } from "react-zxing";
import { useNavigate } from "react-router-dom";

export const MembershipScanner = () => {
  const navigate = useNavigate();
  const { ref } = useZxing({
    onDecodeResult(decodedResult) {
      fetch('/purchase/pay/' + decodedResult, {method: 'POST'})
        .then(response => response.json())
        .catch(error => console.error('Error posting membership', error))
        .then(navigate('/'))
    }
  });

  return (
    <>
      <video style={{ width: "600px", height: "400px" }} ref={ref} />
    </>
  );
};