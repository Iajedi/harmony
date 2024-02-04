import Box from "@mui/material/Box";
import { useState } from "react";
import Typography from "@mui/material/Typography";
import Modal from "@mui/material/Modal";
import { Link } from "react-router-dom";

const style = {
  position: 'absolute',
  top: '50%',
  left: '50%',
  transform: 'translate(-50%, -50%)',
  width: 600,
  height: 400,
  fontSize: '24px',
  bgcolor: 'background.paper',
  border: '2px solid #000',
  boxShadow: 24,
  p: 4,
};

const BasicModal = () => {
  const [open, setOpen] = useState(false);
  const handleOpen = () => setOpen(true);
  const handleClose = () => setOpen(false);

  return (
    <div>
      <button onClick={handleOpen} style={{ fontSize: '20px', padding: '5px' }}>Pay by card</button>
      <Modal
        open={open}
        onClose={handleClose}
      >
        <Box sx={style}>
          <Typography style={{ position: 'absolute', left: '19.5%', top: '30%' }} id="modal-modal-description" variant="h3">
            <strong>Confirm Payment</strong>
          </Typography>
          <Link to="/membership">
            <button style={{ position: 'absolute', left: '32%', top: '50%' }}>Pay</button>
          </Link>
        </Box>
      </Modal>
    </div>
  );
}

export default BasicModal;