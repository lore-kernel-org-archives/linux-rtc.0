Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904F43CCFD2;
	Tue, 29 Sep 2026 21:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790718512; cv=none; b=o5jwmsT8wJakvlBn5cavmSluI0oJKX4vtkMbeFb2WXUVbkus8meFoBXr8wY9LELruvA8K22UxJKObROoDIOfR0Kk61jRelj6o9XtMPqhXCOXoDrzofcquz8VA1THbB/053FS/3MmQMXlu5kji8u06Zp424nImnRIyqNE7JQT9ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790718512; c=relaxed/simple;
	bh=GWmvwj+nORo0EWQgRL+UgZnBah9OR8tb06mwcbd+pgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeCfhtqWLaITEe2fJa9eEOzLT+wLfBKjMt9FrWsHfAc+ixZaGzweBDDkGZkeyPj3djhdu7C6sy3RzRCcdrjx7awam/vTk0taSNQ3+hEFDE4vXUnb3HRcbykJ01m8auwUHldesvhOifRnJs+BvwgK9CFRnAC/Zxiyh3KA7mXvVv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2x1BvzJA; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2x1BvzJA"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7AF164E410AF;
	Tue, 29 Sep 2026 21:48:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4DDE3601BD;
	Tue, 29 Sep 2026 21:48:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 88733103295D5;
	Tue, 29 Sep 2026 23:48:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790718500; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=tNY2nMHpXTQMwRb4EtGa7fbXYJPj910XzwZSiKsA6lE=;
	b=2x1BvzJAZ8G7RebZNCGzug6UcptMR1h+2WFmRk7gJo4Xfw3cREvWJvFIsMysfX2x3t2YZ7
	m4eIvK7Ff33TB7jsot7FXa4LRCkQoHxRLVrrQtwk8UHigtgxQ2/2kOIQmUj01QmpMu0puX
	SzpG3FWCWA6Rg6Rz4q7q2rcFos7ebWND3J3znjVrUhFRmBwwuRXox/R+036RoHDUKEB4Im
	rH/vFLUfh1MwcdZ8kK7wjpKT1mq2mJ4zNYOe2rR5Q5ueLMKfuqrDj5mtVZqgh/f+AQhe8C
	V9teQPe5fPPYIam2ON3FvKLTnMxUzuZj9mYdgwuaAY8H8lTItR5+COIOs79taA==
Date: Tue, 29 Sep 2026 23:48:17 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Liu Dalin <liudalin@kylinsec.com.cn>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Deng Yingchao <dengyingchao@kylinsec.com.cn>,
	Qin Yungao <qinyungao@kylinsec.com.cn>,
	Luo Qiu <luoqiu@kylinsec.com.cn>
Subject: Re: [PATCH] rtc: rs5c372: add missing error code for unknown RTC type
Message-ID: <2026092921481727857dc7@mail.local>
References: <C18300C5767FC690+20260827015846.3314353-1-liudalin@kylinsec.com.cn>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C18300C5767FC690+20260827015846.3314353-1-liudalin@kylinsec.com.cn>
X-Last-TLS-Session-Version: TLSv1.3

On 27/08/2026 09:58:46+0800, Liu Dalin wrote:
> In rs5c372_probe(), when an unknown RTC type is encountered in the
> switch default case, the local variable 'err' is still 0 from its
> initialization. The subsequent goto to the exit label then returns
> success, even though probe has failed.
> 
> Set err = -ENODEV before jumping to exit to properly report the
> failure to the caller.
> 
> Fixes smatch warnings:
> - drivers/rtc/rtc-rs5c372.c:860 rs5c372_probe() warn: missing error
>   code 'err'
> 
> Fixes: cb26b572dc394 ("[PATCH] Update the rtc-rs5c372 driver")
> Assisted-by: smatch:2.0 [static analysis]
> Signed-off-by: Liu Dalin <liudalin@kylinsec.com.cn>
> ---
>  drivers/rtc/rtc-rs5c372.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
> index 24bd795d9d95..84407119caba 100644
> --- a/drivers/rtc/rtc-rs5c372.c
> +++ b/drivers/rtc/rtc-rs5c372.c
> @@ -857,6 +857,7 @@ static int rs5c372_probe(struct i2c_client *client)
>  		break;
>  	default:
>  		dev_err(&client->dev, "unknown RTC type\n");
> +		err = -ENODEV;

But isn't this dead code that will never be reached? In what case would
you be probed and not match any i2c_device_id?

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
