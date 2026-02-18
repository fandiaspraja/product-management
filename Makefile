
screen:
	@read -p "Enter the feature_name: " featureName; \
	@read -p "Enter the page_name: " pageName; 	\

	

screens:
	bloc create screen hihiw;
	



translate:
	flutter gen-l10n

feature:
	@read -p "Enter the feature_name: " featureName; \
	mkdir -p lib/features/$$featureName; \
	mkdir -p lib/features/$$featureName/data; \
	mkdir -p lib/features/$$featureName/domain; \
	mkdir -p lib/features/$$featureName/presentation; \
	mkdir -p lib/features/$$featureName/domain/entity; \
	mkdir -p lib/features/$$featureName/domain/repository; \
	mkdir -p lib/features/$$featureName/domain/usecase; \
	mkdir -p lib/features/$$featureName/presentation/bloc; \
	mkdir -p lib/features/$$featureName/presentation/pages; \
	mkdir -p lib/features/$$featureName/presentation/widgets; \
	mkdir -p lib/features/$$featureName/presentation/strings; \
	mkdir -p lib/features/$$featureName/data/models; \
	mkdir -p lib/features/$$featureName/data/repositories; \
	mkdir -p lib/features/$$featureName/data/datasources; \
	mkdir -p lib/features/$$featureName/data/datasources; \
	mkdir -p lib/features/$$featureName/data/datasources/remote; \
	mkdir -p lib/features/$$featureName/data/datasources/local; \
	echo "" > lib/features/$$featureName/data/datasources/remote/$${featureName}_remote_data_source.dart; \
	echo "" > lib/features/$$featureName/data/datasources/local/$${featureName}_local_data_source.dart; \
	echo "" > lib/features/$$featureName/data/datasources/$${featureName}_remote_data_source_impl.dart; \
	echo "" > lib/features/$$featureName/data/datasources/$${featureName}_local_data_source_impl.dart; \
	echo "" > lib/features/$$featureName/data/models/$${featureName}_response.dart; \
	echo "" > lib/features/$$featureName/data/models/$${featureName}_request.dart; \
	echo "" > lib/features/$$featureName/data/repositories/$${featureName}_repository_impl.dart; \
	echo "" > lib/features/$$featureName/domain/repository/$${featureName}_repository.dart; \
	echo "" > lib/features/$$featureName/domain/usecase/$${featureName}_usecase.dart; \
	echo "" > lib/features/$$featureName/domain/entity/$${featureName}_entity.dart; \
	echo "import 'package:bloc/bloc.dart';\nimport 'package:equatable/equatable.dart';\npart '$${featureName}_event.dart';\npart '$${featureName}_state.dart';\nclass $${featureName}Bloc extends Bloc<$${featureName}EventBloc, $${featureName}StateBloc> {\n$${featureName}Bloc(super.initialState);\n}" > lib/features/$$featureName/presentation/bloc/$${featureName}_bloc.dart; \
	echo "part of '$${featureName}_bloc.dart';\nabstract class $${featureName}EventBloc extends Equatable {\nconst $${featureName}EventBloc();\n@override \nList<Object> get props => []; \n}" > lib/features/$$featureName/presentation/bloc/$${featureName}_event.dart; \
	echo "part of '$${featureName}_bloc.dart';\nabstract class $${featureName}StateBloc extends Equatable {\nconst $${featureName}StateBloc();\n@override \nList<Object> get props => []; \n}" > lib/features/$$featureName/presentation/bloc/$${featureName}_state.dart; \



