Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8013B4D597C
	for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792340787; cv=none; b=I8zFPG7m1qFvJu1Yg91XtaXN4PxshSRqALzdePsvm9pdfMfmBxsnvBq4bId84dYAIVMGHlf6lScsZ6GSn5HZLY9KUsy4A3nGoIMOPmgGaabAZcJpaaTeTrIrv05VE3io3GE273OprRnZfTDNxIrbVZffg4uonU0iL9s2IDi/2MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792340787; c=relaxed/simple;
	bh=G4S1n3I+vN415jixgniNKq1lBfK4ap4+2xCFZJvljTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSFAtfxnuFckXR+GTo7MjFj8HR/gi8iSGc3s7Ol4uKaaYHipIfms5ZxLgsXEnkg+SIFtkWoWxNbnIfzbxSgwVwGmEpJFP9VApZYJUz1NSlrunRPFHBUaR/voPmDhEtfp5qkRAvDIEdSFPZ5I6PhMnCdzgR2YoaTAeWPLeW98mqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s3ipWvTP; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3ipWvTP"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso1074195a91.1
        for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 09:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792340786; x=1792945586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=r4CcxdQ2oJybJSNbjjXimwSvVRvmuOa37brscnwQTP4=;
        b=s3ipWvTPS7U8hkOE5XRzFbEkyhGh1zx0IZDL6mKYeUaw8yLilO/+a35SVpvc1gs6Qo
         RIWx8aAHYJYa3B29rWipZXYB1t3377vMWgqsF8yTITz4Pmbp+jNryGBWrMQdvpGlyFng
         1n3rWPhu/M3wDFS0LgyxrfAmhMQm8XpPIH4jCQKvCuGqO3JoaxNK09dP4wiKyk4ixRxX
         tak7IQ/0lT996uyqIP0CIPrs9kDkbgXkoUSjFx6tdRSvcgUaHxFmp5YxMy5AM0akA0+u
         3TwkQZukKd5AM0ZijSDub40bEaAFMpwsfhzmi8Xgjwq7VKXES1NyQrNxTKMuRxAuI9uQ
         QDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792340786; x=1792945586;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r4CcxdQ2oJybJSNbjjXimwSvVRvmuOa37brscnwQTP4=;
        b=MhalblnJBtcNL1PQjSPiRKmzBA8B/VQLBI0d6tEi34yJRwLeVaFKcRcsGPUA0B/VGa
         TU7c8+MrylqknpqjuAkfELVB/pHbrKOzhHdoReXM/MX4GlVndeW6woV63KdNzB2CcPMi
         A50xULA/O4tqkbvUIhCzddbE8Hsd0LIVT+zatQcf1vbGjJzLPNsKLslAjomBCucYRgke
         eslqLY1/WjxyMxsWqJduXAGNZR4BcEt61Wfpzr5OWe13Ziia6O+P7GisCtlUV8HK4rP3
         2wVycOxybBvgv+a18c9/KJBQQ6UrsKoDU6Sqmu94h7OzchmJXa0C5mU4EeJC5nI6mFRA
         YQow==
X-Forwarded-Encrypted: i=1; AKwUvBwFZj7sH9VlDMESojql6FJ3omruJzxPCt2dUc9HU1/ZTnxCvrxRZdr66GcVQkhP1PcBmhP92+t2DA4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL5DnAzXJa9KZvYrh+pM7JrSNr5ngVZjUcs+M+5ubSuvukV0hTS
	aINQWlAnfQ/j1cpQoz7UF5KqLewLwGn+kv/pI0Fr3WiowJPOkDIR8J3A
X-Gm-Gg: AYBFou21TKWBXJXl4hXNGGZJUPvPG6QVuS+SFY96fmZW5302JoGm8wJsb26cmudMeOQ
	ZenDDMhVVLNfWJzLbnX2EXrJdP/EtusC+yrPJdvujJoYLb0XUATfeQdeDsYsBmwozkIg5Uds8mg
	FCdoIhZYIamLITX8An6gA/ngDZ3WvSB8QF6etwphILaHd4lbBCaFGPZY5z7CGjM8FZ5pWkYggoe
	QJ0DoXLnhbRv0i6gwlb/oHy5BctFXNZrbtDc/nOJKHlOO8R6OqEuGSzwYrJGdEy/A3IsuVQw+1n
	CiK28G3pTwIKcqQNVR8QZcEV9oqRf5fGCMtycXblW7m4y7tabZ7RmYAfbxWTBIws3xGoZ/Z3igJ
	qcbnGHqZTIgXfG0zQyGiJezGL5LEOYxgqQjj72XQHNbR+Px2Uif0sETds6HAc5e/sew6DrbKY8s
	OEflYS8IrIe1VFzZRE0cWuvaJxf582HMGROXo1qeVDFTGfiz+xPpXL5Owh8wKfzQfo+9yjXdjbo
	/iRpKXRTH0Q
X-Received: by 2002:a17:90a:da87:b0:3ab:36c4:b502 with SMTP id 98e67ed59e1d1-3acef19656fmr4952624a91.30.1792340785847;
        Sun, 18 Oct 2026 09:26:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc43a1981sm12210945a91.2.2026.10.18.09.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 09:26:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 18 Oct 2026 09:26:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rudolf Marek <r.marek@assembler.cz>,
	Andi Shyti <andi.shyti@kernel.org>,
	Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Duncan Sands <duncan.sands@free.fr>,
	Chas Williams <3chas3@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] hwmon: Replace __MODULE_STRING() with
 __stringify()
Message-ID: <49d1de69-ffce-490f-bbee-80513cfd0cba@roeck-us.net>
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
 <20261002-module-string-v2-1-fc7438acaf4d@suse.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-module-string-v2-1-fc7438acaf4d@suse.com>

On Fri, Oct 02, 2026 at 10:31:01AM +0200, Petr Pavlu wrote:
> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
> MODULE_PARM support for older modules" [1] in 2002-12. That change also
> moved it to the graveyard section at the end of linux/module.h
> 
> Replace the remaining uses of __MODULE_STRING() with __stringify() in
> preparation for its removal.
> 
> Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Applied.

Thanks,
Guenter
