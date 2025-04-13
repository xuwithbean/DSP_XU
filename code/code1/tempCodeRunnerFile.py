    'MediumNN': KNeighborsClassifier(n_neighbors=10),
    'WideNN': KNeighborsClassifier(n_neighbors=20),
    'SubspaceKNN': KNeighborsClassifier(n_neighbors=5, metric='manhattan')
}
validation_acc = []
for name, clf in knn_classifiers.it