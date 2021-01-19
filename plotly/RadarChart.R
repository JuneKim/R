install.packages(plotly)
library(plotly)

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

takenTime_base512k = list(0.1702, 0.1848, 0.2013, 0.2181, 0.2362)
tr_base512k = list(3259.3576, 3087.8644, 2926.0432, 2792.6052, 2699.8964)
conn_base512k = list(9.1528, 21.796, 11.4221, 11.642, 14.1761)
processing_base512k = list(160.6299, 175.3827, 206.5695, 222.1782)
waiting_base512k = list(9.9382, 10.132, 10.8503, 11.6454, 12.7494)
total_base512k = list(169.8373, 184.9858, 201.2572,218.2234, 236.3519)

takenTime_drop512k = list(6.481777778, 6.5346, 6.5857, 6.6392, 6.7178)
tr_drop512k = list(79.05544444, 78.5737, 78.0853, 77.5887, 76.9684)
conn_drop512k = list(6071.118333, 6072.7334, 6075.0736,6076.7761, 6080.0753 )
processing_drop512k = list(410.743, 461.783, 510.9037, 562.461, 637.4777)
waiting_drop512k = list(9.682555556, 26.9321, 40.137, 55.8502, 61.981)
total_drop512k = list(6481.863667, 6534.5158, 6585.7785,6639.2337, 6717.5576)

takenTime_switch512k = list(4.274777778, 4.4418, 4.2358, 4.3225, 4.7384 )
tr_switch512k = list(160.3443333, 153.0997, 159.8529, 156.8797, 142.8052)
conn_switch512k = list(3988.368, 4118.7504, 3901.80376,3940.2005, 4272.2794 )
processing_switch512k = list(286.451, 322.4934, 333.99984, 382.5568, 465.9397)
waiting_switch512k = list(13.51633333, 16.3491, 21.715, 32.8995, 43.0033)
total_switch512k = list(4274.812222, 4615.449556, 4235.7999,4322.7632, 4738.228)

x_data = list(10, 20, 30, 40, 50)

# Taken Time #################
yaxis<-list(
  title = 'Taken Time for a Request (sec)',
  tick0 = 0,
  dtick = 1,
  tickfont=list(size=20),
  #tickformat :".000",
  fixedrange = T,
  range = c(0, 10),
  linewidth=2,
  gridwidth=5,
  showgrid=T,
  titlefont=list(size=20)
)

plot_ly(type='scatter', mode='lines+markers') %>%
  add_trace(x= x_data, y = takenTime_base512k, name = "no-MTD (512KB)", line = list(color='grey', dash='dot'), marker=list(color='grey', opacity=0.5, symbol = 'circle', size = 10)) %>%
  add_trace(x= x_data, y = takenTime_drop512k, name = "Drop with MTD (512KB)", line = list(color='red', dash='dot'), marker=list(color='red', opacity=0.5, symbol = 'star', size = 10)) %>%
  add_trace(x= x_data, y = takenTime_switch512k, name = "Switch-over with MTD (512KB)", line = list(color='green', dash='dot'), marker=list(color='green', opacity=0.5, symbol = 'pentagon', size = 10)) %>%
  layout(xaxis=xaxis, yaxis=yaxis, legend=list(x= 100, y = 0.5, orientation='h'))


### Transfer Rate #######3
yaxis<-list(
  title = 'Transfer Rate (Bytes/s)',
  tick0 = 0,
  dtick = 500,
  tickfont=list(size=20),
  #tickformat :".000",
  fixedrange = T,
  range = c(0, 4500),
  linewidth=2,
  gridwidth=5,
  showgrid=T,
  titlefont=list(size=20)
)

plot_ly(type='scatter', mode='lines+markers') %>%
  add_trace(x= x_data, y = tr_base512k, name = "no-MTD (512KB)", line = list(color='grey', dash='dot'), marker=list(color='grey', opacity=0.5, symbol = 'circle', size = 10)) %>%
  add_trace(x= x_data, y = tr_drop512k, name = "Drop with MTD (512KB)", line = list(color='red', dash='dot'), marker=list(color='red', opacity=0.5, symbol = 'star', size = 10)) %>%
  add_trace(x= x_data, y = tr_switch512k, name = "Switch-over with MTD (512KB)", line = list(color='green', dash='dot'), marker=list(color='green', opacity=0.5, symbol = 'pentagon', size = 10)) %>%
  layout(xaxis=xaxis, yaxis=yaxis, legend=list(x= 100, y = 0.5, orientation='h'))

#10 30 50
library(fmsb)

# Create data: note in High school for several students
colnames <- c("Connecting" , "Processing" , "Waiting" , "Total" )

# To use the fmsb package, I have to add 2 lines to the dataframe: the max and min of each variable to show on the plot!
data <- rbind(rep(20,5) , rep(0,5) , data)

# Color vector
colors_border=c( rgb(0.2,0.5,0.5,0.9), rgb(0.8,0.2,0.5,0.9) , rgb(0.7,0.5,0.1,0.9) )
colors_in=c( rgb(0.2,0.5,0.5,0.4), rgb(0.8,0.2,0.5,0.4) , rgb(0.7,0.5,0.1,0.4) )

# plot with default options:
radarchart( data  , axistype=1 , 
            #custom polygon
            pcol=colors_border , pfcol=colors_in , plwd=4 , plty=1,
            #custom the grid
            cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,20,5), cglwd=0.8,
            #custom labels
            vlcex=0.8 
)

# Add a legend
legend(x=0.7, y=1, legend = rownames(data[-c(1,2),]), bty = "n", pch=20 , col=colors_in , text.col = "grey", cex=1.2, pt.cex=3)#drop
plot_ly(type='scatter', mode='lines+markers') %>%
  add_trace(x= x_data, y = drop_512k, name = "Drop with MTD (512KB)", line = list(color='red', dash='dot'), marker=list(color='red', opacity=0.5, symbol = 'star',size = 10)) %>%
  add_trace(x= x_data, y = drop_1m, name = "Drop with MTD (1MB)", line = list(color='red', dash='dash'), marker=list(color='red', opacity=0.5, symbol = 'star', size = 10)) %>%
  add_trace(x= x_data, y = drop_2m, name = "Drop with MTD (2MB)", line = list(color='red'), marker=list(color='red', opacity=0.5, symbol = 'star', size = 10)) %>%
  layout(xaxis=xaxis, yaxis=yaxis, legend=list(x= 0.2, y = 100, orientation='h'))

#switch
plot_ly(type='scatter', mode='lines+markers') %>%
  add_trace(x= x_data, y = switch_512k, name = "Switch-over with MTD (512KB)", line = list(color='green', dash='dot'), marker=list(color='green', opacity=0.5, symbol = 'pentagon', size = 10)) %>%
  add_trace(x= x_data, y = switch_1m, name = "Switch-over with MTD (1MB)", line = list(color='green', dash='dash'), marker=list(color='green', opacity=0.5, symbol = 'pentagon', size = 10)) %>%
  add_trace(x= x_data, y = switch_2m, name = "Switch-over with MTD (2MB)", line = list(color='green'), marker=list(color='green', opacity=0.5, symbol = 'pentagon', size = 10)) %>%
  layout(xaxis=xaxis, yaxis=yaxis, legend=list(x= 0.2, y = 100, orientation='h'))

#512k
plot_ly(type='scatter', mode='lines+markers') %>%
  add_trace(x= x_data, y = base_512k, name = "no-MTD (512KB)", line = list(color='grey', dash='dot'), marker=list(color='grey', opacity=0.5, symbol = 'circle', size = 10)) %>%
  add_trace(x= x_data, y = drop_512k, name = "Drop with MTD (512KB)", line = list(color='red', dash='dot'), marker=list(color='red', opacity=0.5, symbol = 'star',size = 10)) %>%
  add_trace(x= x_data, y = switch_512k, name = "Switch-over with MTD (512KB)", line = list(color='green', dash='dot'), marker=list(color='green', opacity=0.5, symbol = 'pentagon', size = 10)) %>%
  layout(xaxis=xaxis, yaxis=yaxis, legend=list(x= 0.2, y = 100, orientation='h'))

#1m
#switch
plot_ly(type='scatter', mode='lines+markers') %>%
  add_trace(x= x_data, y = drop_1m, name = "Drop with MTD (1MB)", line = list(color='red', dash='dash'), marker=list(color='red', opacity=0.5, symbol = 'star', size = 10)) %>%
  add_trace(x= x_data, y = switch_1m, name = "Switch-over with MTD (1MB)", line = list(color='green', dash='dash'), marker=list(color='green', opacity=0.5, symbol = 'pentagon', size = 10)) %>%
  layout(xaxis=xaxis, yaxis=yaxis, legend=list(x= 0.2, y = 100, orientation='h'))


#2m
plot_ly(type='scatter', mode='lines+markers') %>%
  add_trace(x= x_data, y = base_2m, name = "no-MTD (2MB)", line = list(color='grey'), marker=list(color='grey', opacity=0.5, symbol = 'circle', size = 10)) %>%
  add_trace(x= x_data, y = drop_2m, name = "Drop with MTD (2MB)", line = list(color='red'), marker=list(color='red', opacity=0.5, symbol = 'star', size = 10)) %>%
  add_trace(x= x_data, y = switch_2m, name = "Switch-over with MTD (2MB)", line = list(color='green'), marker=list(color='green', opacity=0.5, symbol = 'pentagon', size = 10)) %>%
  layout(xaxis=xaxis, yaxis=yaxis, legend=list(x= 0.2, y = 100, orientation='h'))



install.packages("fmsb")
library(fmsb)

# Create data: note in High school for several students
set.seed(99)
data <- as.data.frame(matrix( sample( 0:20 , 15 , replace=F) , ncol=5))
colnames(data) <- c("math" , "english" , "biology" , "music" , "R-coding" )
rownames(data) <- paste("mister" , letters[1:3] , sep="-")

# To use the fmsb package, I have to add 2 lines to the dataframe: the max and min of each variable to show on the plot!
data <- rbind(rep(20,5) , rep(0,5) , data)


colors_border=c( rgb(0.2,0.5,0.5,0.9), rgb(0.8,0.2,0.5,0.9) , rgb(0.7,0.5,0.1,0.9) )
colors_in=c( rgb(0.2,0.5,0.5,0.4), rgb(0.8,0.2,0.5,0.4) , rgb(0.7,0.5,0.1,0.4) )

# plot with default options:
# plot with default options:
radarchart(data, cglcol="grey", cglty=1)


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

base_512k = list(0,0,0,0,0)
base_1m = list()
base_2m = list(0, 0, 0, 0, 0.0121)
base_4m = list(0.0, 0.0, 0.1503, 0.4598, 0.5850)
drop_512k = list(0.1016, 0.1083, 0.1093, 0.1145, 0.1201)
drop_1m = list(0.1032, 0.1148, 0.1260, 0.1445, 0.1673)
drop_2m = list(0.1677, 0.2134, 0.3034, 0.4856, 0.6601)
drop_4m = list(0.2217, 0.5210, 0.7794, 0.9052, 0.9512)
switch_512k= list(0.1126, 0.089, 0.0854, 0.0917, 0.1011)
switch_1m= list(0.0952, 0.0971, 0.0855, 0.0917, 0.1225)
switch_2m= list(0.1352, 0.1317, 0.1764, 0.3026,  0.4094)
switch_4m = list(0.1914, 0.3215, 0.5390, 0.7903, 0.8927) 
x_data = list(10, 20, 30, 40, 50)

#noMTD
plot_ly(type='scatter', mode='lines+markers') %>%
  add_trace(x= x_data, y = base_512k, name = "no-MTD (512KB)", line = list(color='grey', dash='dot'), marker=list(color='grey', opacity=0.5, symbol = 'circle', size = 10)) %>%
  add_trace(x= x_data, y = base_2m, name = "no-MTD (2MB)", line = list(color='grey'), marker=list(color='grey', opacity=0.5, symbol = 'circle', size = 10)) %>%
  layout(xaxis=xaxis, yaxis=yaxis, legend=list(x= 0.2, y = 100, orientation='h'))
#drop
plot_ly(type='scatter', mode='lines+markers') %>%
  add_trace(x= x_data, y = drop_512k, name = "Drop with MTD (512KB)", line = list(color='red', dash='dot'), marker=list(color='red', opacity=0.5, symbol = 'star',size = 10)) %>%
  add_trace(x= x_data, y = drop_1m, name = "Drop with MTD (1MB)", line = list(color='red', dash='dash'), marker=list(color='red', opacity=0.5, symbol = 'star', size = 10)) %>%
  add_trace(x= x_data, y = drop_2m, name = "Drop with MTD (2MB)", line = list(color='red'), marker=list(color='red', opacity=0.5, symbol = 'star', size = 10)) %>%
  layout(xaxis=xaxis, yaxis=yaxis, legend=list(x= 0.2, y = 100, orientation='h'))

#switch
plot_ly(type='scatter', mode='lines+markers') %>%
  add_trace(x= x_data, y = switch_512k, name = "Switch-over with MTD (512KB)", line = list(color='green', dash='dot'), marker=list(color='green', opacity=0.5, symbol = 'pentagon', size = 10)) %>%
  add_trace(x= x_data, y = switch_1m, name = "Switch-over with MTD (1MB)", line = list(color='green', dash='dash'), marker=list(color='green', opacity=0.5, symbol = 'pentagon', size = 10)) %>%
  add_trace(x= x_data, y = switch_2m, name = "Switch-over with MTD (2MB)", line = list(color='green'), marker=list(color='green', opacity=0.5, symbol = 'pentagon', size = 10)) %>%
  layout(xaxis=xaxis, yaxis=yaxis, legend=list(x= 0.2, y = 100, orientation='h'))

#512k
plot_ly(type='scatter', mode='lines+markers') %>%
  add_trace(x= x_data, y = base_512k, name = "no-MTD (512KB)", line = list(color='grey', dash='dot'), marker=list(color='grey', opacity=0.5, symbol = 'circle', size = 10)) %>%
  add_trace(x= x_data, y = drop_512k, name = "Drop with MTD (512KB)", line = list(color='red', dash='dot'), marker=list(color='red', opacity=0.5, symbol = 'star',size = 10)) %>%
  add_trace(x= x_data, y = switch_512k, name = "Switch-over with MTD (512KB)", line = list(color='green', dash='dot'), marker=list(color='green', opacity=0.5, symbol = 'pentagon', size = 10)) %>%
  layout(xaxis=xaxis, yaxis=yaxis, legend=list(x= 0.2, y = 100, orientation='h'))

#1m
#switch
plot_ly(type='scatter', mode='lines+markers') %>%
  add_trace(x= x_data, y = drop_1m, name = "Drop with MTD (1MB)", line = list(color='red', dash='dash'), marker=list(color='red', opacity=0.5, symbol = 'star', size = 10)) %>%
  add_trace(x= x_data, y = switch_1m, name = "Switch-over with MTD (1MB)", line = list(color='green', dash='dash'), marker=list(color='green', opacity=0.5, symbol = 'pentagon', size = 10)) %>%
  layout(xaxis=xaxis, yaxis=yaxis, legend=list(x= 0.2, y = 100, orientation='h'))


#2m
plot_ly(type='scatter', mode='lines+markers') %>%
  add_trace(x= x_data, y = base_2m, name = "no-MTD (2MB)", line = list(color='grey'), marker=list(color='grey', opacity=0.5, symbol = 'circle', size = 10)) %>%
  add_trace(x= x_data, y = drop_2m, name = "Drop with MTD (2MB)", line = list(color='red'), marker=list(color='red', opacity=0.5, symbol = 'star', size = 10)) %>%
  add_trace(x= x_data, y = switch_2m, name = "Switch-over with MTD (2MB)", line = list(color='green'), marker=list(color='green', opacity=0.5, symbol = 'pentagon', size = 10)) %>%
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


