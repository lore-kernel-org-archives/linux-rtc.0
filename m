Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FB0387341
	for <linux-rtc@vger.kernel.org>; Thu, 15 Oct 2026 21:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792101189; cv=none; b=ory3X3wlJ7yv/jLOiv+jcMBHlHqj3wpSTfhIay5IAgR6NGcz/W78UwIPBVVUtyleLAwNJZ48Pf3r6rVZEJhpkqY83rSs1r/vKlVDTD0f7by5UJUDWnhKTaMBTLxUuS2gZdLQC/dVE8JCzJq6GfqZ5LaPFVYBLKkaC4B7YB6OdVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792101189; c=relaxed/simple;
	bh=uP49FBvXzxwQaoH3/H+q5gaTQYkqJhRlFh0JRBmezWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=II41/LS91cUMxH0ySYnLDsgxx0EcSsR7A+cADC8Kipi3yGAiycNlha2VZn2wt1OrFJ/y2XiAjJ1SPX2tXrHkyK4Sn+ftjZqMr3CSHPD32ZJrb/1PDCMI+PlFMvLx9iYsGTdUMAsRrHMsYQNtOxRjfymSk7eBMVyzp4ww+g4uLZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=nldYfJV8; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="nldYfJV8"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-917997ab0d9so67596406d6.3
        for <linux-rtc@vger.kernel.org>; Thu, 15 Oct 2026 14:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792101185; x=1792705985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GoZFyFHEBIbbXLJkNjI5j8IRtrjCYfTrNzWJlPEfUWI=;
        b=nldYfJV8sGM7SpQ+iADxF9zokhox19bXDmA87nY1vC6lNY9eOyv8skI+DPws640Udp
         B8t+h5yqcc4K7biWhrgsi3g9uMDtndMwTWoq4yBLGpibq++rK5NZrAHqX3uRVVfyZYS/
         huDwyRzyK21FLXpAGtgf4Re7T0p1PSVod4NNwizx6/1qAiQYPKkJJzOsepruUoAMUTEO
         2qGrDk8fASXtYUH4EyDiaN3ED8amiHZwfdUCmpSnc/LmVpskYUOJkYXHXxa9vvqS9Cu9
         3cbCc9Iqjvu18+R4KdnZnu4xZCxLmpe6UvqlcJJwDMQW1tZq3GeplXSsZTWhckD63InR
         zJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792101185; x=1792705985;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GoZFyFHEBIbbXLJkNjI5j8IRtrjCYfTrNzWJlPEfUWI=;
        b=vywkJ0E/8BQL8TabTOWagW20pu8g7xTE+X9wwTGQHE1+5qyUIw8OgaJY74LHLVlrtk
         NQ3CgiYXJttKcCEB0b846ytNI1Mfdmy4sc2aCNIRJb/2W1ZRYKhTbhtJ4/GIhJ0aVsEZ
         zizkJ7KpYhZzDco5hkM2A/G5B22bSXqQzwcPa/8bkWHL6yKSGvCWM1MdmKoXg9HUDMuA
         O1EEyv5UbiRDk2FeV46+Oa9JrYDPdLRtZ+CDu0e02f51Jvrtvw/4D2GwWKPeiPLyWAAl
         OZBDhYT8PW3gz7ZrskAMLl9tpatZ8HeY6ZYQKRcRxVlDmhlaQzxVRTHChS57QtXqzTQm
         m2dw==
X-Gm-Message-State: AFq9FYLnQrEJx0cqJ390adDhlYyzk7YS0OhRqzCSPZ2Rmt8zXOFz/yM3
	CZzOgUYasUFr+/Rn/+0f8/AoLA2EzExUsxVl7NkmZHFwzdneSGv+DRlo+I8g546rw8Q=
X-Gm-Gg: AYBFou30lP/EbnE3NQ38ibC/EXksJ+KlGsLJx6QQd2eflySQe5FSHHnWJb/+784GcrF
	TvQBm6f8svj9BimakZCIv/pAk96QJ4eVrb3nMlJuU5tBpg7Yj9UEF+dy6dkJvgoxpogshFO7+jz
	v8GHk4LwdwiRYFz7bCtRyJZsCrYcQYtcEteIZ1DJ72VILB69tv+xW2gs2VqIj1ProfflN2y/1d/
	MBtL0Bqv7+5RuoSNEI5soJMQxqzomJMWxcO3o2i+fFrPTqRIOeEY6V58WjEoHhP+tI4qMsXzNMN
	ZkLnhWEo8bHo1rllJ87WTPkA+T+1zOiYufpwEIIrGRGnbY1fJOzQ4ZEqpaBvDCyY+4/l0upHq91
	mZwu373M29YWwfrEOJNyGmyOg1JQBamLHXLKJjVT0JELnbfvmNiolerCNLCOR8OfR3cq9OOGUgA
	Efu1FoPP9+zjDekVyQy8nHpoCWn83A8w73Yprqh5M91BV/qFtCvVmFERonDWhSmxRbSeKwAw/TF
	338ynhJ8673uD8o5EKrchOeT/zlWeTMRCG/wx5LVHzPceqOEE0rkco=
X-Received: by 2002:a05:6214:410a:b0:917:c904:4ae7 with SMTP id 6a1803df08f44-91b5555df66mr379187676d6.42.1792101185337;
        Thu, 15 Oct 2026 14:53:05 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcbaae54fsm6259516d6.19.2026.10.15.14.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 14:53:04 -0700 (PDT)
Date: Thu, 15 Oct 2026 17:53:03 -0400
From: Gregory Price <gourry@gourry.net>
To: sashiko-reviews@lists.linux.dev
Cc: linux-rtc@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [RESEND PATCH 1/2] rtc: cmos: Disable ACPI RTC event before
 handling it
Message-ID: <atFKh05sL0FpV8Q4@gourry-fedora-PF4VCD3F>
References: <20261015173029.3091872-1-gourry@gourry.net>
 <20261015173029.3091872-2-gourry@gourry.net>
 <sashiko-outbox-173261@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-173261@kernel.org>

On Thu, Oct 15, 2026 at 05:42:19PM +0000, sashiko-bot@kernel.org wrote:
> > diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> > index fa04ece151b8b..fe514b1aa3433 100644
> > --- a/drivers/rtc/rtc-cmos.c
> > +++ b/drivers/rtc/rtc-cmos.c
> > @@ -758,7 +758,9 @@ static u32 rtc_handler(void *context)
> >  	unsigned char rtc_intr;
> >  	unsigned long flags;
> >  
> > -
> > +	/* Quiesce this event before rtc->irqwork can arm the next one. */
> > +	acpi_clear_event(ACPI_EVENT_RTC);
> > +	acpi_disable_event(ACPI_EVENT_RTC, 0);
> 
> [Severity: Medium]
> Could this unconditional disablement create a race with concurrent userspace
> threads setting a new alarm?
> 
> If a concurrent userspace thread calls ioctl(RTC_ALM_SET), it acquires the
> necessary locks and enables the ACPI event for the newly configured alarm:
> 
> drivers/rtc/rtc-cmos.c:rtc_wake_on() {
>         acpi_clear_event(ACPI_EVENT_RTC);
>         acpi_enable_event(ACPI_EVENT_RTC, 0);
> }
>
> While the patch successfully resolves a similar race with the worker thread
> by moving the disablement before cmos_interrupt(), it seems to leave the
> asynchronous userspace race unhandled.
> 

This is a pre-existing issue.

~Gregory
