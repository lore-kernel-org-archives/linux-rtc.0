Date: Mon, 19 Dec 2016 01:17:34 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com
Subject: Re: [PATCH 1/1] rtc: rx8010: change lock mechanism
Message-ID: <20161219001734.ghsir573a45ksuxv@piout.net>
References: <1481017294-1712-1-git-send-email-fabien.lahoudere@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1481017294-1712-1-git-send-email-fabien.lahoudere@collabora.co.uk>
List-ID: <rtc-linux.googlegroups.com>

Hi Fabien,

On 06/12/2016 at 10:41:34 +0100, Fabien Lahoudere wrote :
> @@ -288,12 +281,11 @@ static int rx8010_set_alarm(struct device *dev, struct rtc_wkalrm *t)
>  	u8 alarmvals[3];
>  	int extreg, flagreg;
>  	int err;
> -	unsigned long irqflags;
>  
> -	spin_lock_irqsave(&rx8010->flags_lock, irqflags);
> +	mutex_lock(&rx8010->rtc->ops_lock);

This is not needed, the lock is already taken before calling
->set_alarm.

>  	flagreg = i2c_smbus_read_byte_data(client, RX8010_FLAG);
>  	if (flagreg < 0) {
> -		spin_unlock_irqrestore(&rx8010->flags_lock, irqflags);
> +		mutex_unlock(&rx8010->rtc->ops_lock);
>  		return flagreg;
>  	}
>  
> @@ -302,14 +294,14 @@ static int rx8010_set_alarm(struct device *dev, struct rtc_wkalrm *t)
>  		err = i2c_smbus_write_byte_data(rx8010->client, RX8010_CTRL,
>  						rx8010->ctrlreg);
>  		if (err < 0) {
> -			spin_unlock_irqrestore(&rx8010->flags_lock, irqflags);
> +			mutex_unlock(&rx8010->rtc->ops_lock);
>  			return err;
>  		}
>  	}
>  
>  	flagreg &= ~RX8010_FLAG_AF;
>  	err = i2c_smbus_write_byte_data(rx8010->client, RX8010_FLAG, flagreg);
> -	spin_unlock_irqrestore(&rx8010->flags_lock, irqflags);
> +	mutex_unlock(&rx8010->rtc->ops_lock);
>  	if (err < 0)
>  		return err;
>  
> @@ -404,7 +396,6 @@ static int rx8010_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
>  	struct rx8010_data *rx8010 = dev_get_drvdata(dev);
>  	int ret, tmp;
>  	int flagreg;
> -	unsigned long irqflags;
>  
>  	switch (cmd) {
>  	case RTC_VL_READ:
> @@ -419,16 +410,16 @@ static int rx8010_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
>  		return 0;
>  
>  	case RTC_VL_CLR:
> -		spin_lock_irqsave(&rx8010->flags_lock, irqflags);
> +		mutex_lock(&rx8010->rtc->ops_lock);

It is also taken before calling ->ioctl.

>  		flagreg = i2c_smbus_read_byte_data(rx8010->client, RX8010_FLAG);
>  		if (flagreg < 0) {
> -			spin_unlock_irqrestore(&rx8010->flags_lock, irqflags);
> +			mutex_unlock(&rx8010->rtc->ops_lock);
>  			return flagreg;
>  		}
>  
>  		flagreg &= ~RX8010_FLAG_VLF;
>  		ret = i2c_smbus_write_byte_data(client, RX8010_FLAG, flagreg);
> -		spin_unlock_irqrestore(&rx8010->flags_lock, irqflags);
> +		mutex_unlock(&rx8010->rtc->ops_lock);
>  		if (ret < 0)
>  			return ret;
>  
> @@ -466,8 +457,6 @@ static int rx8010_probe(struct i2c_client *client,
>  	rx8010->client = client;
>  	i2c_set_clientdata(client, rx8010);
>  
> -	spin_lock_init(&rx8010->flags_lock);
> -
>  	err = rx8010_init_client(client);
>  	if (err)
>  		return err;
> -- 
> 1.8.3.1
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
