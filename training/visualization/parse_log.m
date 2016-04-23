function parse_log(filepath, skip_fist_loss, smooth_step, max_iters)
if ~exist('smooth_step', 'var')
  smooth_step = 1;
end

if ~exist('max_iters', 'var')
  max_iters = Inf;
end

% filepath = '/home/wyang/code/pose/convolutional-pose-machines/training/prototxt/LEEDS_PC/caffemodel/parse_log/train_04_14_16.log.train';
info = fopen(filepath);

header = strsplit(fgetl(info), ',');
num_iters = [];
losses = cell(length(header)-3, 1);

cnt = 1;
iterinfo = strsplit(fgetl(info), ',');
while cnt < max_iters
  num_iters = [num_iters; str2num(iterinfo{1})];
  for ii = 1:length(losses)
    losses{ii} = [losses{ii}; str2double(iterinfo{3+ii})]; 
  end
  try
    iterinfo = strsplit(fgetl(info), ',');
  catch
    break;
  end
  cnt = cnt + 1;
end

fclose(info);

% ------ draw graphs ------
colors = colormap(jet(length(losses)));
ymax = 10000; 
for ii = 1:length(losses)
  if ymax > max(losses{ii}(skip_fist_loss:end)); % skip first 10 losses
    ymax = max(losses{ii}(skip_fist_loss:end));
  end
  loss = smooth_loss(losses{ii}, smooth_step);
  plot(num_iters, loss, 'Color', colors(ii, :), 'LineWidth', 2); hold on;
end
ymin = min(cell2mat(losses));
axis([0 num_iters(end) ymin ymax]);
legend(header(4:end));
xlabel('# Iters');
ylabel('Loss');
grid on;

function loss = smooth_loss(loss, steps)
for i = 1:length(loss)
  loss(i) = mean(loss(i:min(i+steps, length(loss))));
end


