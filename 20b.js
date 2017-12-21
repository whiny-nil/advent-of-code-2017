const fs = require("fs");
const RE = /p=<(.*?)>, v=<(.*?)>, a=<(.*?)>/;
let particles = fs
  .readFileSync("inputs/20.txt", "utf8")
  .split("\n")

particles.pop();

particles = particles.map(row => {
    const match = row.match(RE);
    const parts = match.slice(1).map(v => v.split(",").map(vv => +vv));
    const partToVec = part => ({ x: part[0], y: part[1], z: part[2] });
    return {
      p: partToVec(parts[0]),
      v: partToVec(parts[1]),
      a: partToVec(parts[2])
    };
  });

function update(particles) {
  particles.forEach(particle => {
    particle.v.x += particle.a.x;
    particle.v.y += particle.a.y;
    particle.v.z += particle.a.z;

    particle.p.x += particle.v.x;
    particle.p.y += particle.v.y;
    particle.p.z += particle.v.z;
  });

  // collisions
  let collisions = [];
  for (let i = 0; i < particles.length; i++) {
    for (let j = 1; j < particles.length; j++) {
      if (i === j) continue;
      const a = particles[i];
      const b = particles[j];

      if (a.p.x === b.p.x && a.p.y === b.p.y && a.p.z === b.p.z) {
        collisions = collisions.concat(i, j);
      }
    }
  }

  let newParticles = [];
  for (let i = 0; i < particles.length; i++) {
    if (!collisions.includes(i)) {
      newParticles.push(particles[i]);
    }
  }
  return newParticles;
}

function dists(particles) {
  return particles.map(particle => {
    return (
      Math.abs(particle.p.x) + Math.abs(particle.p.y) + Math.abs(particle.p.z)
    );
  });
}

let closest = dists(particles);
const MAX = 1000;
for (var i = 0; i < MAX; i++) {
  particles = update(particles);
  const d = dists(particles);
  d.forEach((dd, index) => {
    if (closest[index] < dd) {
      closest[index] = dd;
    }
  });
  if (i % 1000 === 0) {
    console.log(i, particles.length, i / MAX * 100);
  }
}


let min = Number.MAX_SAFE_INTEGER;
let minIndex = 0;
closest.forEach((v, idx) => {
  if (v < min) {
    minIndex = idx;
    min = v;
  }
});

console.log("Part 1", minIndex, min);
console.log("Part 2", particles.length);

