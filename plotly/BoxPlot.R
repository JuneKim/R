library(plotly)

#jobs_total.csv

base_512k <-read.csv(file = "jobs_total.csv")
drop_512k_with <-read.csv(file = "jobs1_total.csv")
drop_512k_without <-read.csv(file = "jobs2_total.csv")

base_name <- "Baseline"
drop_with_name <- "Drop with IP/Port Check"
drop_without_name <- "Drop with IP Check"
#Connection


xaxis<-list(
  visible=F
)

yaxis<-list(
  title = 'Time (s)',
  tick0 = 0,
  dtick = 5,
  tickfont=list(size=15),
  fixedrange = T,
  range = c(0, 30),
  linewidth=2,
  gridwidth=5,
  showgrid=T,
  titlefont=list(size=15)
)

fig1 <- plot_ly(type="box")
fig1 <- fig1 %>% add_trace(y = base_512k$Total.mean.ms. / 1000, 
                         marker = list(color="black"), 
                         line = list(color="black"),
                         fillcolor = "lightblack",
                         name=base_name, boxpoints=FALSE, showlegend = FALSE)
fig1 <- fig1 %>% add_trace(y = drop_512k_with$Total.mean.ms. / 1000, 
                         marker = list(color="red"), 
                         line = list(color="red"),
                         fillcolor = "lightred",
                         name=drop_with_name, boxpoints = FALSE, showlegend = FALSE)
fig1 <- fig1 %>% add_trace(y = drop_512k_without$Total.mean.ms. / 1000, 
                         marker = list(color="oragne"), 
                         line = list(color="orange"),
                         fillcolor = "lightorange",
                         name=drop_without_name, boxpoints = FALSE, showlegend = FALSE)
fig1 <- fig1 %>% layout(xaxis = xaxis, yaxis = yaxis)

#Connect Time
fig2 <- plot_ly(type="box")
fig2 <- fig2 %>% add_trace(y = base_512k$Connect.median.ms. / 1000, 
                         marker = list(color="black"), 
                         line = list(color="black"),
                         fillcolor = "lightblack",
                         name=base_name, boxpoints=FALSE, showlegend = FALSE)
fig2 <- fig2 %>% add_trace(y = drop_512k_with$Connect.median.ms. / 1000, 
                         marker = list(color="red"), 
                         line = list(color="red"),
                         fillcolor = "lightred",
                         name=drop_with_name, boxpoints = FALSE, showlegend = FALSE)
fig2 <- fig2 %>% add_trace(y = drop_512k_without$Connect.median.ms. / 1000, 
                         marker = list(color="oragne"), 
                         line = list(color="orange"),
                         fillcolor = "lightorange",
                         name=drop_without_name, boxpoints = FALSE, showlegend = FALSE)
fig2 <- fig2 %>% layout(xaxis = xaxis, yaxis = yaxis,
                       showlegend=FALSE)

fig3 <- plot_ly(type="box")
fig3 <- fig3 %>% add_trace(y = base_512k$Waiting.mean.ms. / 1000, 
                           marker = list(color="black"), 
                           line = list(color="black"),
                           fillcolor = "lightblack",
                           name=base_name, boxpoints=FALSE, showlegend = FALSE)
fig3 <- fig3 %>% add_trace(y = drop_512k_with$Waiting.mean.ms. / 1000, 
                           marker = list(color="red"), 
                           line = list(color="red"),
                           fillcolor = "lightred",
                           name=drop_with_name, boxpoints = FALSE, showlegend = FALSE)
fig3 <- fig3 %>% add_trace(y = drop_512k_without$Waiting.mean.ms. / 1000, 
                           marker = list(color="oragne"), 
                           line = list(color="orange"),
                           fillcolor = "lightorange",
                           name=drop_without_name, boxpoints = FALSE, showlegend = FALSE)
fig3 <- fig3 %>% layout(xaxis = xaxis, yaxis = yaxis,
                        showlegend=FALSE)

fig4 <- plot_ly(type="box")
fig4 <- fig4 %>% add_trace(y = (base_512k$Processing.mean.ms. - base_512k$Waiting.mean.ms.) / 1000, 
                           marker = list(color="black"), 
                           line = list(color="black"),
                           fillcolor = "lightblack",
                           name=base_name, boxpoints=FALSE)
fig4 <- fig4 %>% add_trace(y = (drop_512k_with$Processing.median.ms. - drop_512k_with$Waiting.mean.ms.) / 1000, 
                           marker = list(color="red"), 
                           line = list(color="red"),
                           fillcolor = "lightred",
                           name=drop_with_name, boxpoints = FALSE)
fig4 <- fig4 %>% add_trace(y = (drop_512k_without$Processing.median.ms. - drop_512k_without$Waiting.median.ms.) / 1000, 
                           marker = list(color="oragne"), 
                           line = list(color="orange"),
                           fillcolor = "lightorange",
                           name=drop_without_name, boxpoints = FALSE)
fig4 <- fig4 %>% layout(xaxis = xaxis, yaxis = yaxis,
                        showlegend=TRUE, legend=list(x= 0.4, y = -1000, font=list(size=10)))
fig <- subplot(margin = 0.05, nrows = 2, fig1, fig2, fig3, fig4, shareY=TRUE)
fig


yaxis<-list(
  title = 'Mean of Fraction of failed jobs',
  tick0 = 0,
  dtick = 0.1,
  tickfont=list(size=20),
  #tickformat :".000",
  fixedrange = T,
  range = c(0, 1.0),
  linewidth=2,
  gridwidth=5,
  showgrid=T,
  titlefont=list(size=20)
)

xaxis<-list(
  title = 'Request rate (#/min)',
  tick0 = 10,
  dtick = 10,
  tickfont=list(size=20),
  fixedrange = T,
  range = c(0, 60),
  linewidth=2,
  gridwidth=2,
  showgrid=T,
  titlefont=list(size=20)
)


base_512 = list(0, 0, 0, 0, 0)
drop_with_512 = list(0.1016, 0.1083, 0.1093, 0.1145, 0.1201)
drop_without_512 = list(0.0037, 0.02871, 0.0026, 0.0044, 0.0691)
x_data = list(10, 20, 30, 40, 50)

plot_ly(type='scatter', mode='lines+markers') %>%
  add_trace(x= x_data, y = base_512, name = "no-MTD", line = list(color='black'), marker=list(color='black', opacity=0.5, symbol = 'circle', size = 10)) %>%
  add_trace(x= x_data, y = drop_with_512, name = drop_with_name, line = list(color='red', dash='dot'), marker=list(color='red', opacity=0.5, symbol = 'star', size = 10)) %>%
  add_trace(x= x_data, y = drop_without_512, name = drop_without_name, line = list(color='orange', dash='dot'), marker=list(color='orange', opacity=0.5, symbol = 'star', size = 10)) %>%
  layout(xaxis=xaxis, yaxis=yaxis, legend=list(x= 0.2, y = 100, orientation='h'))



