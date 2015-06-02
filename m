Return-Path: <rtc-linux+bncBDS7HNEFSALRBKHIXCVQKGQEN5DXEEA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id p12si745138wiv.1.2015.06.02.15.54.32
        for <rtc-linux@googlegroups.com>;
        Tue, 02 Jun 2015 15:54:32 -0700 (PDT)
Date: Wed, 3 Jun 2015 00:54:06 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 2/2] rtc: change "client->irq >= 0" to
 "client->irq > 0"
Message-ID: <20150602225406.GJ1715@piout.net>
References: <1433280853-3988-1-git-send-email-octavian.purdila@intel.com>
 <1433280853-3988-3-git-send-email-octavian.purdila@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1433280853-3988-3-git-send-email-octavian.purdila@intel.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 03/06/2015 at 00:34:13 +0300, Octavian Purdila wrote :
> Since commit dab472eb931b ("i2c / ACPI: Use 0 to indicate that device

You can't reference that commit ID as Linus Torvalds didn't pull that
patch yet.

I'd also prefer a more descriptive subject line.

> does not have interrupt assigned"), 0 is not a valid i2c client irq
> anymore, so change all driver's checks accordingly.
> 
> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> ---
>  drivers/rtc/rtc-ds1374.c | 4 ++--
>  drivers/rtc/rtc-ds3232.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
> index 167783f..592458c 100644
> --- a/drivers/rtc/rtc-ds1374.c
> +++ b/drivers/rtc/rtc-ds1374.c
> @@ -689,7 +689,7 @@ static int ds1374_suspend(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
>  
> -	if (client->irq >= 0 && device_may_wakeup(&client->dev))
> +	if (client->irq > 0 && device_may_wakeup(&client->dev))
>  		enable_irq_wake(client->irq);
>  	return 0;
>  }
> @@ -698,7 +698,7 @@ static int ds1374_resume(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
>  
> -	if (client->irq >= 0 && device_may_wakeup(&client->dev))
> +	if (client->irq > 0 && device_may_wakeup(&client->dev))
>  		disable_irq_wake(client->irq);
>  	return 0;
>  }
> diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
> index 7e48e53..f280dd1 100644
> --- a/drivers/rtc/rtc-ds3232.c
> +++ b/drivers/rtc/rtc-ds3232.c
> @@ -443,7 +443,7 @@ static int ds3232_remove(struct i2c_client *client)
>  {
>  	struct ds3232 *ds3232 = i2c_get_clientdata(client);
>  
> -	if (client->irq >= 0) {
> +	if (client->irq > 0) {
>  		mutex_lock(&ds3232->mutex);
>  		ds3232->exiting = 1;
>  		mutex_unlock(&ds3232->mutex);
> -- 
> 1.9.1
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
