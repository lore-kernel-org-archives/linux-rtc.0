Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBWUP6TBQKGQERIKGKCY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id e134si863506wmd.3.2017.01.16.09.50.18
        for <rtc-linux@googlegroups.com>;
        Mon, 16 Jan 2017 09:50:18 -0800 (PST)
Date: Mon, 16 Jan 2017 18:50:18 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 1/2] RTC: s35390a: handle invalid RTC time
Message-ID: <20170116175018.z74inrcapwqqtbcz@piout.net>
References: <1484217818-27845-1-git-send-email-fabien.lahoudere@collabora.co.uk>
 <1484217818-27845-2-git-send-email-fabien.lahoudere@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1484217818-27845-2-git-send-email-fabien.lahoudere@collabora.co.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 12/01/2017 at 11:43:37 +0100, Fabien Lahoudere wrote :
> If RTC time have been altered by low voltage, we notify users
> that RTC time is invalid by returning -EINVAL.
> The RTC time needs to be set correctly to clear the invalid flag.
> If the RTC is not set before restarting, the information will be lost.
> 
> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
> ---
>  drivers/rtc/rtc-s35390a.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> index 5dab466..ef4ada9 100644
> --- a/drivers/rtc/rtc-s35390a.c
> +++ b/drivers/rtc/rtc-s35390a.c
> @@ -62,6 +62,7 @@ struct s35390a {
>  	struct i2c_client *client[8];
>  	struct rtc_device *rtc;
>  	int twentyfourhour;
> +	int isinvalid;
>  };
>  
>  static int s35390a_set_reg(struct s35390a *s35390a, int reg, char *buf, int len)
> @@ -135,6 +136,8 @@ static int s35390a_reset(struct s35390a *s35390a, char *status1)
>  	 * The 24H bit is kept over reset, so set it already here.
>  	 */
>  initialize:
> +	/* set the RTC time as invalid */
> +	s35390a->isinvalid = 1;
>  	*status1 = S35390A_FLAG_24H;
>  	buf = S35390A_FLAG_RESET | S35390A_FLAG_24H;
>  	ret = s35390a_set_reg(s35390a, S35390A_CMD_STATUS1, &buf, 1);
> @@ -221,6 +224,8 @@ static int s35390a_set_datetime(struct i2c_client *client, struct rtc_time *tm)
>  		buf[i] = bitrev8(buf[i]);
>  
>  	err = s35390a_set_reg(s35390a, S35390A_CMD_TIME1, buf, sizeof(buf));
> +	if (err >= 0)
> +		s35390a->isinvalid = 0;
>  
>  	return err;
>  }
> @@ -231,6 +236,9 @@ static int s35390a_get_datetime(struct i2c_client *client, struct rtc_time *tm)
>  	char buf[7];
>  	int i, err;
>  
> +	if (s35390a->isinvalid)
> +		return -EINVAL;
> +

That's fine but what happens if it became invalid between probe and
s35390a_get_datetime()? (This is particularly relevant after patch 2/2.

>  	err = s35390a_get_reg(s35390a, S35390A_CMD_TIME1, buf, sizeof(buf));
>  	if (err < 0)
>  		return err;
> @@ -418,6 +426,7 @@ static int s35390a_probe(struct i2c_client *client,
>  
>  	s35390a->client[0] = client;
>  	i2c_set_clientdata(client, s35390a);
> +	s35390a->isinvalid = 0;
>  
>  	/* This chip uses multiple addresses, use dummy devices for them */
>  	for (i = 1; i < 8; ++i) {
> -- 
> 1.8.3.1
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
