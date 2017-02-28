#-----------------------------------------
#  Expriment1. Convolutional NN Model 1
#-----------------------------------------

import matplotlib.pyplot as plt
plt.style.use('ggplot')

def simple_print(y_label,value1_list,value1_label, value2_list, value2_label, step_list):
    fig = plt.figure(figsize=(8, 4))
    ax = fig.add_subplot(111)
    ax.set_xlabel('Epoch Num')
    ax.set_ylabel(y_label)
    ax.plot(step_list, value1_list, label=value1_label)
    ax.plot(step_list, value2_list, label=value2_label)
    ax.grid('on')
    plt.legend(bbox_to_anchor=(1.05, 1), loc=2, borderaxespad=0.)

train_error_lst=[]
train_accur_lst=[]
valid_error_lst=[]
valid_accur_lst=[]
epoch_lst=[]


simple_print('Error',train_error_lst,'train error', valid_error_lst, 'valid error', epoch_lst)
simple_print('Accuracy',train_accur_lst,'train accuracy', valid_accur_lst, 'valid accuracy', epoch_lst)
