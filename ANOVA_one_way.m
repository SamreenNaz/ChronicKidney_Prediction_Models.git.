clc
clear all

% Generate sample performance metrics (accuracy) for each method
cnn_accuracy = [0.95, 0.98, 0.89];
svm_accuracy = [0.88, 0.91, 0.97]; % Modified values to reduce differences
random_forest_accuracy = [0.97, 0.87, 0.91]; % Modified values to reduce differences

% Combine accuracy values for ANOVA
accuracy_data = [cnn_accuracy', svm_accuracy', random_forest_accuracy'];

% Perform one-way ANOVA
[p_anova, tbl, stats] = anova1(accuracy_data, {'CNN', 'SVM', 'Random Forest'});

% Print ANOVA table
disp('ANOVA Table:');
disp(tbl);

% Perform post-hoc tests (Tukey's HSD)
[c, m, h, nms] = multcompare(stats);

% Plot boxplot with light color inner boxes
figure;
h = boxplot(accuracy_data, {'CNN', 'SVM', 'Random Forest'});
title('Performance Comparison');
ylabel('Accuracy');
xlabel('Classification Method');

% Add individual data points to the boxplot
hold on;
num_methods = size(accuracy_data, 2);
for i = 1:num_methods
    x = repmat(i, size(accuracy_data, 1), 1);
    scatter(x, accuracy_data(:, i), 'k', 'filled');
end
hold off;

% Calculate residuals
residuals = zeros(size(accuracy_data));
for i = 1:size(accuracy_data, 2)
    residuals(:, i) = accuracy_data(:, i) - mean(accuracy_data(:, i));
end

% Plot residual plot to test ANOVA assumptions
figure;
qqplot(residuals(:));
title('Residual Plot to Test ANOVA Assumptions');
xlabel('Theoretical Quantiles');
ylabel('Standardized Residuals');