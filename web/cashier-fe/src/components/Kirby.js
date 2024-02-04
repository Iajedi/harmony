import { useCallback, useEffect, useRef, useState } from "react";

const kirbySize = 64;
const kirbyBackgroud = new Image();
kirbyBackgroud.src = "./kirby.png";

let kirbyLeftIdx = 0;
let kirbyLeft = 0;
let kirbyTop = 0;
let lastTime = 0;

const draw = (ctx, now) => {
  if (!ctx) return;
  if (now - lastTime >= 1000) {
    lastTime = now;
    kirbyLeftIdx = (kirbyLeftIdx + 1) % 4;
    kirbyLeft = -kirbySize * kirbyLeftIdx;

    ctx.clearRect(0, 0, kirbySize, kirbySize);
    ctx.drawImage(
      kirbyBackgroud,
      kirbyLeft,
      kirbyTop,
      kirbySize * 4,
      kirbySize * 4
    );
  }
};

export default function Kirby() {
  const canvasRef = useRef(null);
  const [ctx, setCtx] = useState(null);

  const animatekirbyLoop = useCallback(
    (now) => {
      if (!ctx) return;
      draw(ctx, now);
      window.requestAnimationFrame(animatekirbyLoop);
    },
    [ctx]
  );

  useEffect(() => {
    setCtx(canvasRef.current.getContext("2d"));
    window.requestAnimationFrame(animatekirbyLoop);
  }, [canvasRef, animatekirbyLoop]);

  return (
    <div style={{marginLeft: '29px', marginTop: '5px', marginBottom: '5px'}}>
      <canvas ref={canvasRef} width="64" height="64" />
    </div>
  );
}
