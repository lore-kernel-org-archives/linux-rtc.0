Return-Path: <rtc-linux+bncBDS7HNEFSALRBLMYZC2QKGQECDVBZHA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w129si529496wme.1.2016.02.03.06.18.20
        for <rtc-linux@googlegroups.com>;
        Wed, 03 Feb 2016 06:18:20 -0800 (PST)
Date: Wed, 3 Feb 2016 15:18:20 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: dirk.behme@gmail.com
Cc: rtc-linux <rtc-linux@googlegroups.com>, dirk.behme@de.bosch.com,
	linux@rempel-privat.de
Subject: [rtc-linux] Re: rtc: RV8803: BUG: scheduling while atomic
Message-ID: <20160203141820.GB20165@piout.net>
References: <460eec38-0a09-4faa-b601-de64803ed5f3@googlegroups.com>
 <20160203105717.GA20165@piout.net>
 <15c6e090-33f5-4dd4-82bc-d8b7b1f62dcd@googlegroups.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <15c6e090-33f5-4dd4-82bc-d8b7b1f62dcd@googlegroups.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 03/02/2016 at 04:58:53 -0800, dirk.behme@gmail.com wrote :
> Anything like below [1]?
> 
> If you like this, we'll test it.
> 

This seems ok to me.

> Many thanks
> 
> Dirk
> 
> [1]
> 
> diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
> index 33c7e2a..38621ff 100644
> --- a/drivers/rtc/rtc-rv8803.c
> +++ b/drivers/rtc/rtc-rv8803.c
> @@ -52,7 +52,7 @@
>  struct rv8803_data {
>      struct i2c_client *client;
>      struct rtc_device *rtc;
> -    spinlock_t flags_lock;
> +    struct mutex flags_lock;
>      u8 ctrl;
>  };
>  
> @@ -63,11 +63,11 @@ static irqreturn_t rv8803_handle_irq(int irq, void 
> *dev_id)
>      unsigned long events = 0;
>      u8 flags;
>  
> -    spin_lock(&rv8803->flags_lock);
> +    mutex_lock(&rv8803->flags_lock);
>  
>      flags = i2c_smbus_read_byte_data(client, RV8803_FLAG);
>      if (flags <= 0) {
> -        spin_unlock(&rv8803->flags_lock);
> +        mutex_unlock(&rv8803->flags_lock);
>          return IRQ_NONE;
>      }
>  
> @@ -102,7 +102,7 @@ static irqreturn_t rv8803_handle_irq(int irq, void 
> *dev_id)
>                        rv8803->ctrl);
>      }
>  
> -    spin_unlock(&rv8803->flags_lock);
> +    mutex_unlock(&rv8803->flags_lock);
>  
>      return IRQ_HANDLED;
>  }
> @@ -155,7 +155,6 @@ static int rv8803_set_time(struct device *dev, struct 
> rtc_time *tm)
>      struct rv8803_data *rv8803 = dev_get_drvdata(dev);
>      u8 date[7];
>      int flags, ret;
> -    unsigned long irqflags;
>  
>      if ((tm->tm_year < 100) || (tm->tm_year > 199))
>          return -EINVAL;
> @@ -173,18 +172,18 @@ static int rv8803_set_time(struct device *dev, struct 
> rtc_time *tm)
>      if (ret < 0)
>          return ret;
>  
> -    spin_lock_irqsave(&rv8803->flags_lock, irqflags);
> +    mutex_lock(&rv8803->flags_lock);
>  
>      flags = i2c_smbus_read_byte_data(rv8803->client, RV8803_FLAG);
>      if (flags < 0) {
> -        spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
> +        mutex_unlock(&rv8803->flags_lock);
>          return flags;
>      }
>  
>      ret = i2c_smbus_write_byte_data(rv8803->client, RV8803_FLAG,
>                      flags & ~RV8803_FLAG_V2F);
>  
> -    spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
> +    mutex_unlock(&rv8803->flags_lock);
>  
>      return ret;
>  }
> @@ -226,7 +225,7 @@ static int rv8803_set_alarm(struct device *dev, struct 
> rtc_wkalrm *alrm)
>      u8 alarmvals[3];
>      u8 ctrl[2];
>      int ret, err;
> -    unsigned long alarm_time, irqflags;
> +    unsigned long alarm_time;
>  
>      /* The alarm has no seconds, round up to nearest minute */
>      if (alrm->time.tm_sec) {
> @@ -236,11 +235,11 @@ static int rv8803_set_alarm(struct device *dev, 
> struct rtc_wkalrm *alrm)
>          rtc_time_to_tm(alarm_time, &alrm->time);
>      }
>  
> -    spin_lock_irqsave(&rv8803->flags_lock, irqflags);
> +    mutex_lock(&rv8803->flags_lock);
>  
>      ret = i2c_smbus_read_i2c_block_data(client, RV8803_FLAG, 2, ctrl);
>      if (ret != 2) {
> -        spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
> +        mutex_unlock(&rv8803->flags_lock);
>          return ret < 0 ? ret : -EIO;
>      }
>  
> @@ -253,14 +252,14 @@ static int rv8803_set_alarm(struct device *dev, 
> struct rtc_wkalrm *alrm)
>          err = i2c_smbus_write_byte_data(rv8803->client, RV8803_CTRL,
>                          rv8803->ctrl);
>          if (err) {
> -            spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
> +            mutex_unlock(&rv8803->flags_lock);
>              return err;
>          }
>      }
>  
>      ctrl[1] &= ~RV8803_FLAG_AF;
>      err = i2c_smbus_write_byte_data(rv8803->client, RV8803_FLAG, ctrl[1]);
> -    spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
> +    mutex_unlock(&rv8803->flags_lock);
>      if (err)
>          return err;
>  
> @@ -289,7 +288,6 @@ static int rv8803_alarm_irq_enable(struct device *dev, 
> unsigned int enabled)
>      struct i2c_client *client = to_i2c_client(dev);
>      struct rv8803_data *rv8803 = dev_get_drvdata(dev);
>      int ctrl, flags, err;
> -    unsigned long irqflags;
>  
>      ctrl = rv8803->ctrl;
>  
> @@ -305,15 +303,15 @@ static int rv8803_alarm_irq_enable(struct device 
> *dev, unsigned int enabled)
>              ctrl &= ~RV8803_CTRL_AIE;
>      }
>  
> -    spin_lock_irqsave(&rv8803->flags_lock, irqflags);
> +    mutex_lock(&rv8803->flags_lock);
>      flags = i2c_smbus_read_byte_data(client, RV8803_FLAG);
>      if (flags < 0) {
> -        spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
> +        mutex_unlock(&rv8803->flags_lock);
>          return flags;
>      }
>      flags &= ~(RV8803_FLAG_AF | RV8803_FLAG_UF);
>      err = i2c_smbus_write_byte_data(client, RV8803_FLAG, flags);
> -    spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
> +    mutex_unlock(&rv8803->flags_lock);
>      if (err)
>          return err;
>  
> @@ -333,7 +331,6 @@ static int rv8803_ioctl(struct device *dev, unsigned 
> int cmd, unsigned long arg)
>      struct i2c_client *client = to_i2c_client(dev);
>      struct rv8803_data *rv8803 = dev_get_drvdata(dev);
>      int flags, ret = 0;
> -    unsigned long irqflags;
>  
>      switch (cmd) {
>      case RTC_VL_READ:
> @@ -355,16 +352,16 @@ static int rv8803_ioctl(struct device *dev, unsigned 
> int cmd, unsigned long arg)
>          return 0;
>  
>      case RTC_VL_CLR:
> -        spin_lock_irqsave(&rv8803->flags_lock, irqflags);
> +        mutex_lock(&rv8803->flags_lock);
>          flags = i2c_smbus_read_byte_data(client, RV8803_FLAG);
>          if (flags < 0) {
> -            spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
> +            mutex_unlock(&rv8803->flags_lock);
>              return flags;
>          }
>  
>          flags &= ~(RV8803_FLAG_V1F | RV8803_FLAG_V2F);
>          ret = i2c_smbus_write_byte_data(client, RV8803_FLAG, flags);
> -        spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
> +        mutex_unlock(&rv8803->flags_lock);
>          if (ret < 0)
>              return ret;
>  
> @@ -441,6 +438,7 @@ static int rv8803_probe(struct i2c_client *client,
>      if (!rv8803)
>          return -ENOMEM;
>  
> +    mutex_init(&rv8803->flags_lock);
>      rv8803->client = client;
>      i2c_set_clientdata(client, rv8803);
>  
> 
> 
> 
>  


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
