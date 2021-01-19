install.packages(plotly)
library(plotly)


### Change symbols and size of marker
### val of Symbols: https://plot.ly/r/reference/#scatter-marker-symbol
plot_ly(data = mtcars,
            x = ~wt,
            y = ~mpg,
            type='scatter',
            mode='markers',
            symbol= ~as.factor(cyl),
            symbols= c("circle", "x", "o"),
            marker=list(size=5))

#### Change the orientation of the legent (below the plot)  ####
plot_ly(data=mtcars,
             x = ~wt,
             y = ~mpg,
             type ='scatter',
             mode = 'markers',
             symbol = ~as.factor(cyl),
             symbols = c('circle', 'x', 'o'),
             marker = list(size=5)) %>%
        layout(legend=list(orientation='h'))

### Change the orientation of the legend (outside the plot) ###
### Left bottom of plot is the origin 
### if the value == 1, the legend will be located outside, otherwise it is inside of plot
plot_ly(data=mtcars,
             x = ~wt,
             y = ~mpg,
             type ='scatter',
             mode = 'markers',
             symbol = ~as.factor(cyl),
             symbols = c('circle', 'x', 'o'),
             marker = list(size=5)) %>%
  layout(legend=list(x = 0.8, y = 0.9))

### Customize the text over the mouse
plot_ly(data=mtcars,
             x = ~wt,
             y = ~mpg,
             type ='scatter',
             mode = 'markers',
             hoverinfo = "text",
             text=paste("Miles per gallon", mtcars$mpg, "<br>", "Weight: ", mtcars$wt)
             )

### Add annotations to the plot - add_annotations() function syntax
### Example of annotations on a single data points ###
### Display annotations for good mileage
plot_ly(data=mtcars,
        x = ~mpg,
        y = ~wt,
        type='scatter',
        mode='markers') %>%
  add_annotations(x = mtcars$mpg[which.max(mtcars$mpg)],
                  y = mtcars$wt[which.max(mtcars$mpg)],
                  text="Good mileage",
                  showarrow=F)

### Example of annotations - placing text a a desired location on the plot ###
## Display Data Source
### Demo of x/y ref as 'paper'
plot_ly(data=mtcars,
        x = ~mpg,
        y = ~wt,
        type='scatter',
        mode='markers') %>%
  add_annotations(xref="paper", 
              yref="paper",
              x = 0.5, 
              y = 1,
              text="Data Source : mtcars",
              showarrow=F)  

### Add Multiple annotations to the plot - add_annotations() function syntax
### Example of annotations on a single data points ###
### Display annotations for good and bad mileage
plot_ly(data=mtcars,
        x = ~mpg,
        y = ~wt,
        type='scatter',
        mode='markers') %>%
  add_annotations(x = mtcars$mpg[which.max(mtcars$mpg)],
                  y = mtcars$wt[which.max(mtcars$mpg)],
                  text="Good mileage",
                  showarrow=F)%>%
  add_annotations(x = mtcars$mpg[which.min(mtcars$mpg)],
                  y = mtcars$wt[which.min(mtcars$mpg)],
                  text="Bad mileage",
                  showarrow=F)

### Example #2 of annotations on multipile data points ####
# Display annotations for automatic transission cars
plot_ly(data=mtcars,
        x = ~mpg,
        y = ~wt,
        type='scatter',
        mode='markers') %>%
    add_annotations(x = mtcars$mpg[mtcars$am == 0]+2,
                    y = mtcars$wt[mtcars$am == 0],
                    text="auto",
                    showarrow=F)

### Styling annotations ###
# using font argument
plot_ly(data=mtcars,
        x = ~mpg,
        y = ~wt,
        type='scatter',
        mode='markers') %>%
  add_annotations(x = mtcars$mpg[which.max(mtcars$mpg)],
                  y = mtcars$wt[which.max(mtcars$mpg)],
                  text="Good mileage",
                  font=list(color="green", family="sans serif", size= 15))

### Set the range of Y axis
yaxis <- list(
  title = 'Y-axis Title',
  #ticktext = list('long label','Very long label','3','label', "what", "The", "Seven"),
  #tickvals = list(1, 2, 3, 4, 5, 6, 7),
  #tickmode = "array",
  range=list(0,10)
  #automargin = TRUE,
  #titlefont = list(size=30)
)
plot_ly(x = c('Apples', 'Oranges', 'Watermelon', 'Pears'), y = c(3, 1, 2, 5),
        width = 500, height = 500, type = 'bar') %>%
  layout(yaxis = yaxis)

### Set the range of scale at axis
## Disable autoscale according to the x or y-axis data
xaxis <- list(
  title = 'Request rate (λ)',
  ticktext = list('10','30','60'),
  tickvals = list("10", "30", "60"),
  tickmode = "array",
  titlefont = list(size=10)
)
yaxis<-list(
  title = 'Failure Rate',
  tick0 = 0,
  dtick = 0.1,
  gridwidth = 2,
  fixedrange=T,
  range= c(0, 0.7),
  autosize=T,
  titlefont = list(size=10)
)
short_drop = list(0.005, 0.0133, 0.0158)
short_wait = list(0.03, 0.0383, 0.0392)
long_drop = list(0.035, 0.1000, 0.5767)
long_wait = list(0.03, 0.0767, 0.4225)
x_data = list("10", "30", "60")
plot_ly (type='scatter', mode='markers') %>%
  add_trace(x= x_data,y = short_drop, name = "Drop strategy", marker=list(color = "blue", 
                                      opacity= 0.5, symbol="pentagon", size=10) ) %>%
  add_trace(x= x_data, y = short_wait, name = "Wait strategy", marker=list(color = "red", 
                                      opacity= 0.5, symbol="star", size=10) ) %>%
  layout(title = "Short jobs", xaxis = xaxis, yaxis=yaxis, legend=list(x = 0.5, y = 1, orientation='h'))

yaxis<-list(
  title = 'Fraction of failed jobs',
  tick0 = 0,
  dtick = 0.05,
  tickfont=list(size=20),
  fixedrange = T,
  range = c(0, 0.5),
  linewidth=2,
  gridwidth=5,
  showgrid=T,
  titlefont=list(size=20)
)

xaxis<-list(
  title = 'Request rate (λ)',
  tick0 = 0,
  dtick = 50,
  tickfont=list(size=20),
  fixedrange = T,
  range = c(0, 460),
  linewidth=2,
  gridwidth=2,
  showgrid=T,
  titlefont=list(size=20)
)


m4_no_mtd = list (0.0, 0.0, 0.0, 0.0, 0.0,0.0, 0.0, 0.0, 0.0, 0.0,0.0, 0.0, 0.0, 0.0, 0.0)
m4_drop = list(0.0053, 0.0089, 0.0125, 0.0121, 0.0118, 0.0128, 0.0153, 0.0185, 0.0234, 
               0.0390, 0.0723, 0.1716, 0.2446, 0.3082, 0.3948)
m4_wait = list(0.0273, 0.0335, 0.0332, 0.0296, 0.0329, 0.0351, 0.0345, 0.0379, 0.0418, 
               0.0516, 0.0743, 0.1091, 0.1459, 0.1633, 0.1991)
x_data = list(30, 60, 90, 120, 150, 180, 210, 240, 270, 300, 330, 360, 390, 420, 450)

plot_ly(type='scatter', mode='lines+markers') %>%
  add_trace(x= x_data, y = m4_no_mtd, name = "no-MTD", line = list(color='black'), 
            marker=list(color='black', opacity=0.5, symbol = 'circle', size = 10)) %>%
  add_trace(x= x_data, y = m4_drop, name = "Drop with MTD", line = list(color='red', 
                        dash='dot'), marker=list(color='red', opacity=0.5, symbol = 'star', size = 10)) %>%
  add_trace(x= x_data, y = m4_wait, name = "Wait with MTD", line = list(color='blue', 
                    dash='dash'), marker=list(color='blue', opacity=0.5, symbol = 'pentagon', size = 10)) %>%
  layout( xaxis=xaxis, yaxis=yaxis, legend=list(x= 0.2, y = 0.9, font=list(size=20)))
  

yaxis<-list(
  title = 'Fraction of failed jobs',
  tick0 = 0,
  dtick = 0.05,
  tickfont=list(size=20),
  fixedrange = T,
  range = c(0, 0.5),
  linewidth=2,
  gridwidth=5,
  showgrid=T,
  titlefont=list(size=20)
)

xaxis<-list(
  title = 'Request rate (λ)',
  tick0 = 0,
  dtick = 50,
  tickfont=list(size=20),
  fixedrange = T,
  range = c(0, 460),
  linewidth=2,
  gridwidth=2,
  showgrid=T,
  titlefont=list(size=20)
)


m4_no_mtd = list (0.0, 0.0, 0.0, 0.0, 0.0,0.0, 0.0, 0.0, 0.0, 0.0,0.0, 0.0, 0.0, 0.0, 0.0)
m4_drop = list(0.0053, 0.0089, 0.0125, 0.0121, 0.0118, 0.0128, 0.0153, 0.0185, 0.0234, 
               0.0390, 0.0723, 0.1716, 0.2446, 0.3082, 0.3948)
m4_wait = list(0.0273, 0.0335, 0.0332, 0.0296, 0.0329, 0.0351, 0.0345, 0.0379, 0.0418, 
               0.0516, 0.0743, 0.1091, 0.1459, 0.1633, 0.1991)
x_data = list(30, 60, 90, 120, 150, 180, 210, 240, 270, 300, 330, 360, 390, 420, 450)

plot_ly(type='scatter', mode='lines+markers') %>%
  add_trace(x= x_data, y = m4_no_mtd, name = "no-MTD", line = list(color='black'), 
            marker=list(color='black', opacity=0.5, symbol = 'circle', size = 10)) %>%
  add_trace(x= x_data, y = m4_drop, name = "Drop with MTD", line = list(color='red', 
                                                                        dash='dot'), marker=list(color='red', opacity=0.5, symbol = 'star', size = 10)) %>%
  add_trace(x= x_data, y = m4_wait, name = "Wait with MTD", line = list(color='blue', 
                                                                        dash='dash'), marker=list(color='blue', opacity=0.5, symbol = 'pentagon', size = 10)) %>%
  layout( xaxis=xaxis, yaxis=yaxis, legend=list(x= 0.2, y = 0.9, font=list(size=20)))


# 21/10 
yaxis<-list(
  title = 'Fraction of failed jobs',
  tick0 = 0,
  dtick = 0.01,
  tickfont=list(size=20),
  #tickformat :".000",
  fixedrange = T,
  range = c(0, 0.06),
  linewidth=2,
  gridwidth=5,
  showgrid=T,
  titlefont=list(size=20)
)

xaxis<-list(
  title = 'Request rate (λ)',
  tick0 = 30,
  dtick = 30,
  tickfont=list(size=20),
  fixedrange = T,
  range = c(30, 150),
  linewidth=2,
  gridwidth=2,
  showgrid=T,
  titlefont=list(size=20)
)


m4_drop = list(0.0049, 0.0079, 0.0100)
m4_wait = list(0.0018, 0.0075, 0.0117)
m4_switchover = list(0.0008, 0.0006, 0.0008)
x_data = list(60, 90, 120)

plot_ly(type='scatter', mode='lines+markers') %>%
  add_trace(x= x_data, y = m4_drop, name = "Drop with MTD", line = list(color='red', 
                                                                        dash='dot'), marker=list(color='red', opacity=0.5, symbol = 'star', size = 10)) %>%
  add_trace(x= x_data, y = m4_wait, name = "Wait with MTD", line = list(color='blue', 
                                                                        dash='dash'), marker=list(color='blue', opacity=0.5, symbol = 'pentagon', size = 10)) %>%
#  add_trace(x= x_data, y = m4_switchover, name = "Switch-over with MTD", line = list(color='green'), 
#            marker=list(color='green', opacity=0.5, symbol = 'circle', size = 10)) %>%
  layout( xaxis=xaxis, yaxis=yaxis, legend=list(x= 0.2, y = 0.9, font=list(size=20)))

# 21/10  - 
yaxis<-list(
  title = 'Fraction of failed jobs',
  tick0 = 0,
  dtick = 0.1,
  tickfont=list(size=20),
  fixedrange = T,
  range = c(0, 0.6),
  linewidth=2,
  gridwidth=5,
  showgrid=T,
  titlefont=list(size=20)
)

xaxis<-list(
  title = 'Request rate (λ)',
  tick0 = 30,
  dtick = 30,
  tickfont=list(size=20),
  fixedrange = T,
  range = c(30, 170),
  linewidth=2,
  gridwidth=2,
  showgrid=T,
  titlefont=list(size=20)
)


m4_wait = list(0.0018, 0.0075, 0.0117, 0.5899)
m4_switchover = list(0.0008, 0.0006, 0.0008, 0.0014)
x_data = list(60, 90, 120, 150)

plot_ly(type='scatter', mode='lines+markers') %>%
  add_trace(x= x_data, y = m4_switchover, name = "Switch-over with MTD", line = list(color='green'), 
            marker=list(color='green', opacity=0.5, symbol = 'circle', size = 10)) %>%
  add_trace(x= x_data, y = m4_wait, name = "Wait with MTD", line = list(color='blue', 
                                                                        dash='dash'), marker=list(color='blue', opacity=0.5, symbol = 'pentagon', size = 10)) %>%
  layout( xaxis=xaxis, yaxis=yaxis, legend=list(x= 0.1, y = 0.9, font=list(size=20)))

#1104
yaxis<-list(
  title = 'Fraction of failed jobs',
  tick0 = 0,
  dtick = 0.01,
  tickfont=list(size=20),
  #tickformat :".000",
  fixedrange = T,
  range = c(0, 0.06),
  linewidth=2,
  gridwidth=5,
  showgrid=T,
  titlefont=list(size=20)
)

xaxis<-list(
  title = 'Request rate (λ)',
  tick0 = 30,
  dtick = 30,
  tickfont=list(size=20),
  fixedrange = T,
  range = c(30, 150),
  linewidth=2,
  gridwidth=2,
  showgrid=T,
  titlefont=list(size=20)
)


m4_drop = list(0.0089, 0.0125, 0.0121)
m4_wait = list(0.0335, 0.0332, 0.0296)
x_data = list(60, 90, 120)

plot_ly(type='scatter', mode='lines+markers') %>%
  add_trace(x= x_data, y = m4_drop, name = "Drop with MTD", line = list(color='red', 
                                                                        dash='dot'), marker=list(color='red', opacity=0.5, symbol = 'star', size = 10)) %>%
  add_trace(x= x_data, y = m4_wait, name = "Wait with MTD", line = list(color='blue', 
                                                                        dash='dash'), marker=list(color='blue', opacity=0.5, symbol = 'pentagon', size = 10)) %>%
  layout( xaxis=xaxis, yaxis=yaxis, legend=list(x= 0.2, y = 0.9, font=list(size=20)))


# 0411
yaxis<-list(
  title = 'Fraction of failed jobs',
  tick0 = 0,
  dtick = 0.1,
  tickfont=list(size=20),
  fixedrange = T,
  range = c(0, 0.6),
  linewidth=2,
  gridwidth=5,
  showgrid=T,
  titlefont=list(size=20)
)

xaxis<-list(
  title = 'Request rate (λ)',
  tick0 = 30,
  dtick = 30,
  tickfont=list(size=20),
  fixedrange = T,
  range = c(30, 170),
  linewidth=2,
  gridwidth=2,
  showgrid=T,
  titlefont=list(size=20)
)


m4_wait = list(0.0018, 0.0075, 0.0117, 0.5899)
m4_switchover = list(0.0008, 0.0006, 0.0008, 0.0014)
x_data = list(60, 90, 120, 150)

plot_ly(type='scatter', mode='lines+markers') %>%
  add_trace(x= x_data, y = m4_switchover, name = "Switch-over with MTD", line = list(color='green'), 
            marker=list(color='green', opacity=0.5, symbol = 'circle', size = 10)) %>%
  add_trace(x= x_data, y = m4_wait, name = "Wait with MTD", line = list(color='blue', 
                                                                        dash='dash'), marker=list(color='blue', opacity=0.5, symbol = 'pentagon', size = 10)) %>%
  layout( xaxis=xaxis, yaxis=yaxis, legend=list(x= 0.1, y = 0.9, font=list(size=20)))

#1104
yaxis<-list(
  title = 'Fraction of failed jobs',
  tick0 = 0,
  dtick = 0.01,
  tickfont=list(size=20),
  #tickformat :".000",
  fixedrange = T,
  range = c(0, 0.05),
  linewidth=2,
  gridwidth=5,
  showgrid=T,
  titlefont=list(size=20)
)

xaxis<-list(
  title = 'Seq of Time Slots (every 20 mins)',
  tick0 = 0,
  dtick = 1,
  tickfont=list(size=20),
  fixedrange = T,
  range = c(0, 6),
  linewidth=2,
  gridwidth=2,
  showgrid=T,
  titlefont=list(size=20)
)


drop_60 = list(0.0049, 0.0042, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
drop_90 = list(0.0059, 0.0029, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
drop_120 = list(0.0162, 0.0117, 0.0012, 0.0, 0.0, 0.0, 0.0, 0.3101, 0.7172, 0.9728)
drop_150 = list(0.0017, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3910, 0.8647, 0.9830, 0.9986)
x_data = list(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

plot_ly(type='scatter', mode='lines+markers') %>%
  add_trace(x= x_data, y = drop_60, name = "60", line = list(color='red', 
                                                                        dash='dot'), marker=list(color='red', opacity=0.5, symbol = 'star', size = 10)) %>%
  add_trace(x= x_data, y = drop_90, name = "90", line = list(color='blue', 
                                                             dash='dot'), marker=list(color='blue', opacity=0.5, symbol = 'star', size = 10)) %>%
  add_trace(x= x_data, y = drop_120, name = "120", line = list(color='green', 
                                                             dash='dot'), marker=list(color='green', opacity=0.5, symbol = 'star', size = 10)) %>%
  add_trace(x= x_data, y = drop_150, name = "150", line = list(color='orange', 
                                                             dash='dot'), marker=list(color='orange', opacity=0.5, symbol = 'star', size = 10)) %>%
  
  layout( xaxis=xaxis, yaxis=yaxis, legend=list(x= 0.7, y = 0.9, font=list(size=20)))


#1104 2mb
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


drop_real = list(0.1677, 0.2134, 0.3034, 0.4856, 0.6601)
base_real = list(0, 0, 0, 0, 0.0121)
switch_real = list(0.1352, 0.1317, 0.1764, 0.3026, 0.4094)
x_data = list(10, 20, 30, 40, 50)

plot_ly(type='scatter', mode='lines+markers') %>%
  add_trace(x= x_data, y = base_real, name = "no-MTD", line = list(color='black', dash='dot'), marker=list(color='black', opacity=0.5, symbol = 'circle', size = 10)) %>%
  add_trace(x= x_data, y = drop_real, name = "Drop with MTD", line = list(color='red', 
                                                                        dash='dot'), marker=list(color='red', opacity=0.5, symbol = 'star', size = 10)) %>%
  add_trace(x= x_data, y = switch_real, name = "Switch-over with MTD", line = list(color='green', 
                                                                     dash='dot'), marker=list(color='green', opacity=0.5, symbol = 'pentagon', size = 10)) %>%
  layout(xaxis=xaxis, yaxis=yaxis, legend=list(x= 0.5, y = 100, orientation='h'))

# 4mb
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


drop_real = list(0.2217, 0.5210, 0.7794, 0.9052, 0.9512)
base_real = list(0, 0, 0.1503, 0.4598, 0.5850, 0.6685)
switch_real = list(0.1914, 0.3215, 0.5390, 0.7903, 0.8927)
x_data = list(10, 20, 30, 40, 50)

plot_ly(type='scatter', mode='lines+markers') %>%
  add_trace(x= x_data, y = base_real, name = "no-MTD", line = list(color='black'), marker=list(color='black', opacity=0.5, symbol = 'circle', size = 10)) %>%
  add_trace(x= x_data, y = drop_real, name = "Drop with MTD", line = list(color='red'), marker=list(color='red', opacity=0.5, symbol = 'star', size = 10)) %>%
  add_trace(x= x_data, y = switch_real, name = "Switch-over with MTD", line = list(color='green'), marker=list(color='green', opacity=0.5, symbol = 'pentagon', size = 10)) %>%
  layout(xaxis=xaxis, yaxis=yaxis, legend=list(x= 0.5, y = 100, orientation='h'))

#1104
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


base_2m = list(0, 0, 0, 0, 0.0121)
base_4m = list(0, 0, 0.1503, 0.4598, 0.5850, 0.6685)
x_data = list(10, 20, 30, 40, 50)

plot_ly(type='scatter', mode='lines+markers') %>%
  add_trace(x= x_data, y = base_2m, name = "no-MTD (2MB)", line = list(color='black', dash='dot'), marker=list(color='black', opacity=0.5, symbol = 'circle', size = 10)) %>%
  add_trace(x= x_data, y = base_4m, name = "no-MTD (4MB)", line = list(color='black'), marker=list(color='black', opacity=0.5, symbol = 'circle', size = 10)) %>%
  layout(xaxis=xaxis, yaxis=yaxis, legend=list(x= 0.2, y = 100, orientation='h'))


#emul
#1104
yaxis<-list(
  title = 'Fraction of failed jobs',
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
  range = c(0, 70),
  linewidth=2,
  gridwidth=2,
  showgrid=T,
  titlefont=list(size=20)
)


drop_real = list(0.0053, 0.0089)
x_data = list(30, 60)

plot_ly(type='scatter', mode='lines+markers') %>%
  add_trace(x= x_data, y = drop_real, name = "Drop with MTD", line = list(color='blue', 
                                                                          dash='dot'), marker=list(color='blue', opacity=0.5, symbol = 'star', size = 10)) %>%
  layout( xaxis=xaxis, yaxis=yaxis, legend=list(x= 0.5, y = 0.2, font=list(size=20)))


