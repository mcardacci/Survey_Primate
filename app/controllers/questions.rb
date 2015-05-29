get '/surveys/:id/questions/new' do
  cur_survey = {id: params[:id]}
  erb :'/questions/new', locals: {survey: cur_survey}, layout: false
end

get '/surveys/:id/questions/edit' do
  cur_question = Question.find_by(survey_id: params[:id])
  erb :"/questions/edit", locals: {survey: cur_question.survey, question: cur_question}, layout: false
end

put '/surveys/:id/questions/:question_id' do
  cur_question = Question.find_by(id: params[:question_id])
  cur_question.update(params[:question])
  erb :'/questions/show', locals: {question: cur_question}, layout: false
end

post '/surveys/:id/questions' do
  new_question = Question.new(body: params[:question][:body], survey_id: params[:id])
  return [500, "Invalid Question"] unless new_question.save
  erb :'/questions/show', locals: {question: new_question}, layout: false
end

delete 'surveys/:id/questions/:question_id' do
  cur_question = Question.find_by(id: params[:question_id])
  if cur_question
    cur_question.destroy
  end
  redirect "/surveys/#{cur_question.survey_id}"
end