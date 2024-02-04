import { Link } from "react-router-dom";
import { BarcodeScanner } from "./Scanner";

function Scan() {
    return (
        <div class="center">
            <h2>Scan new product</h2>
            <BarcodeScanner />
            <Link to="/purchase">
                <button type="button">
                    Back
                </button>
            </Link>
        </div>
    )
}

export default Scan;