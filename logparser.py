import matplotlib.pyplot as plt
%matplotlib inline
plt.style.use('ggplot')

def simple_print(y_label,value1_list,value1_label, value2_list, value2_label, step_list):
    print "simple_print"
    fig = plt.figure(figsize=(8, 4))
    ax = fig.add_subplot(111)
    ax.set_xlabel('Epoch Num')
    ax.set_ylabel(y_label)
    ax.plot(step_list, value1_list, label=value1_label)
    ax.plot(step_list, value2_list, label=value2_label)
    ax.grid('on')
    plt.legend(bbox_to_anchor=(1.05, 1), loc=2, borderaxespad=0.)

filename = "cifar-10-cnn8-DRY.log"
path = "/Users/xuziqiang/Desktop/MLP_Coursework4_s1606776/"
logfile = path+filename
with open(logfile, "r") as ins:
    loglist = []
    for line in ins:
        loglist.append(line)

    print len(loglist)

import re
epoch_lst = []
train_err_lst = []
train_acc_lst = []
epoch_time_lst = []
valid_err_lst= []
valid_acc_lst = []
for i in range(4,len(loglist),6):
    #print loglist[i]
    epoch = re.match(r".*epoch (\d+):" ,loglist[i])
    epoch_lst.append(int(epoch.group(1)))
    #print epoch.group(1)
    train_err = re.match(r".*err\(train\)=(\d+\.*\d+)" ,loglist[i])
    train_err_lst.append(float(train_err.group(1)))
    #print train_err.group(1)
    train_acc = re.match(r".*acc\(train\)=(\d+\.*\d+)" ,loglist[i])
    #print train_acc.group(1)
    train_acc_lst.append(float(train_acc.group(1)))
    epoch_time = re.match(r".*using (\d+\.*\d+)" ,loglist[i])
    #print epoch_time.group(1)
    epoch_time_lst.append(float(epoch_time.group(1)))



    valid_err = re.match(r".*err\(valid\)=(\d+\.*\d+)" ,loglist[i+1])
    valid_err_lst.append(float(valid_err.group(1)))

    valid_acc = re.match(r".*acc\(valid\)=(\d+\.*\d+)" ,loglist[i+1])
    valid_acc_lst.append(float(valid_acc.group(1)))


simple_print('Error',train_err_lst,'train error', valid_err_lst, 'valid error', epoch_lst)
simple_print('Accuracy',train_acc_lst,'train accuracy', valid_acc_lst, 'valid accuracy', epoch_lst)

