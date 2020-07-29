import 'package:checkin/frontend/viewModels/suggestion_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

import '../../models/suggestion.dart';
import '../../widget/suggestion.dart';

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
            children: <Widget>[
              suggestionWidget,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
              RaisedButton(
                onPressed: () => model.enterLog("영암관"),
                child: Text("덕래관"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
