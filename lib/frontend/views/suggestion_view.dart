import 'package:checkin/frontend/viewModels/suggestion_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:checkin/ui/widgets/widgets.dart';
import 'package:checkin/models/models.dart';

// ignore: must_be_immutable
class SuggestionView extends StatelessWidget {
  SuggestionWidget suggestionWidget = new SuggestionWidget();
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SuggestionViewModel>.withConsumer(
      viewModelBuilder: () => SuggestionViewModel(),
      disposeViewModel: false,
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildheader(model.currentUser.fullName, "제안", context),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              suggestionWidget,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 7,
                  ),
                  Expanded(
                    child: RaisedButton(
                      child: Text("지우기"),
                      onPressed: () {
                        suggestionWidget.textController.clear();
                        suggestionWidget.titleController.clear();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Expanded(
                    child: RaisedButton(
                      child: Text("보내기"),
                      onPressed: () {
                        model.addSuggestion(Suggestion(
                            content: suggestionWidget.textController.text,
                            title: suggestionWidget.titleController.text));
                        suggestionWidget.textController.clear();
                        suggestionWidget.titleController.clear();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
