function soft_hand

% note that the masses are constrained to move only vertically
%r = PlanarRigidBodyManipulator('tension.urdf');
r = TimeSteppingRigidBodyManipulator('soft_hand.urdf',.01,struct('twoD',true,'view','top'));

v = r.constructVisualizer();
v.xlim = [-3 16];
v.ylim = [-7 7];

x0 = Point(getStateFrame(r));
x0.ball_x = 11;
x0.ball_y = -.5;

m = r.getManipulator();
l=m.position_constraints{1}.eval(x0(1:getNumPositions(r)))

x0 = resolveConstraints(r,x0); %,v);
v.drawWrapper(0,x0(1:getNumPositions(r)));

v.inspector(x0);
return;

ytraj = simulate(r,[0 8],x0);
if(0)
ts = ytraj.getBreaks();
for i=1:numel(ts)
  x = ytraj.eval(ts(i));
  length(i) = r.position_constraints{1}.eval(x(1:3));
end
figure(1); clf; plot(ts,length);
end

v.playback(ytraj,struct('slider',true));
%v.playbackSWF(ytraj,'tension')

