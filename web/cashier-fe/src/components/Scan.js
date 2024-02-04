import { Link } from "react-router-dom";
import { BarcodeScanner } from "./Scanner";

function Scan() {
    return (
        <div class="center">
            <h2 style={{ textAlign: 'center' }}>Scan new product</h2>
            <BarcodeScanner />
            <h2> </h2>
            <Link to="/purchase">
                <button type="button">
                    Back
                </button>
            </Link>
        </div>
    )
}

export default Scan;