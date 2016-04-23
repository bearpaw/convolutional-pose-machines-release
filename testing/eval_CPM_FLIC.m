% FLIC joint
% 1 nose
% 2 neck (interpolated)
% 3 right shoulder
% 4 right elbow
% 5 right wrist
% 6 right hip
% 7 left shoulder
% 8 left elbow
% 9 left wrist
% 10 left hip
startup;

reference_joints_pair = [6, 7];     % right shoulder and left hip (from observer's perspective)
% symmetry_joint_id(i) = j, if joint j is the symmetry joint of i (e.g., the left
% shoulder is the symmetry joint of the right shoulder).
symmetry_joint_id = [2,1,7,8,9,10,3,4,5,6];
joint_name = {'Head', 'Shou', 'Elbo', 'Wris', 'Hip'};

symmetry_part_id = [1,2,5,6,3,4];
part_name = {'Head', 'Torso', 'U.arms', 'L.arms'};

%% load prediction
all = parload('predicts/FLIC_prediction_model_FLIC_4s.mat','prediction_all');
% always transfer to 10 points
I = [1    2   3   4   5  6  7  8  9   9   10];
J = [1    2   3   4   5  6  7  8  1   4   9];
A = [1    1   1   1   1  1  1  1  1/2 1/2  1];
Trans_all = full(sparse(I,J,A,10,9));

pred = zeros(2, 10, size(all, 3));
for i = 1:size(all, 3)
  pred(:, :, i) = (Trans_all*all(:,:,i))';
end

joint_order = [10, 9, 4, 5, 6, 8, 1, 2, 3, 7];
pred = pred(:, joint_order, :);
%% Evaluate FLIC (Observer Centric)
load('gt/flic-joints-test-oc.mat', 'joints'); % load original FLIC labels
eval_name = 'FLIC-OC';


% im = imread('../dataset/FLIC/images/12-oclock-high-special-edition-00171221.jpg');
% imshow(im); hold on;
% 
% for i = 1:10
%   plot(pred(1, i, 1), pred(2, i, 1), 'r.', 'MarkerSize', 8); hold on;
%   plot(joints(1, i, 1), joints(2, i, 1), 'bo', 'MarkerSize', 12); hold on; pause;
% end

% eval PCP
% load('results/FLIC/pred_sticks_flic_oc.mat', 'pred');
% eval_pcp(pred, joints, symmetry_part_id, part_name, eval_name);

% eval PCK
% load('results/FLIC/pred_keypoints_flic_oc.mat', 'pred');
eval_pck(pred, joints, symmetry_joint_id, joint_name, eval_name);

% eval PDJ
eval_pdj(pred, joints, reference_joints_pair, symmetry_joint_id, joint_name, eval_name);