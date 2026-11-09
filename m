Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239513;
	b=u0VrvZ+lOlfu9J0wFtesHbYtEwGPjybfCMG6nD5QeRpNRs/Gf++TE0Se0dR/lnGuQ+pE
	 OrA1nlv5/xHZmm6puddPC/bFMTTebw+qse0WKyvq74dUAfV8q+xj3piFEsxhPZ1Kows38
	 ezykF3ZYi1wqyt8bS5G4tFnMpDupoEuMNxiAB2Rzd/G7YZ+H+Qrcid1yUn013aIn52tmO
	 SRwCrq4+RM82gaLuzdqXzPvLGbGh+CbRASNEFOXlfkq/ftA/uAQRfvaZ9lxPlQFPDjnx/
	 Ajy3wCvRBC1P/gP0evT4fnNSgQknEHcwugso7hes/k0qemMQoq4XQIWv2NNil3DM8dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Cc:References:
	 Content-Language:To:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=GqcUVOE8YZm1FPDzDze4+rCKgn8rK0xiBVztztTok30=;
	b=OBFJboijZ9HBW8W3Fk234Y6MWSfwcS8hFJK/LRnYFPdKZDVrzlratKWfI58qGFXUcX1U
	 NFfvC110s/nsNUsS1F2SYtQUHcBkqi34a1pY3dpkQ/0m6j2v4rJvcwlZM7tCC6ZlOJ0f1
	 mJuZhCDjOzbPWou74Upxew1gkA/StCtBHyj1qzHEuAVjOCAmFNOt6rIJIxta8H9A/jEw+
	 7Eg4co+6zayhl1dJXKZVgBn0zvsGHyCflOEdAfJMVCqKgrjOftnXOG+AnmgXvb9X+2Iin
	 LR/4NjzFEHRP2x9QchN6C325JyT1IseLWgnBUgQFkBUHOoSBaJVL+DMZlS29OMHILFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=I6Gf+TJ+;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C12606A334
	for <linux-rtc@vger.kernel.org>; Mon,  9 Nov 2026 15:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3C12606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=I6Gf+TJ+
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e3b22e971so563438f8f.0
        for <linux-rtc@vger.kernel.org>; Mon, 09 Nov 2026 07:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794239511; x=1794844311; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:to
         :content-language:references:cc:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GqcUVOE8YZm1FPDzDze4+rCKgn8rK0xiBVztztTok30=;
        b=I6Gf+TJ+xx28C6M6wGa7IriJIxP64CATq5xKa5KY4/dVEF70L68u8oNbC3qDhkhEI7
         7ia14iP5TbkPq0pUWtgTMNnR57unFzAtVelBZ6VlJdQ4CrgVYgxw4RobiXpnUn7hkB+D
         nzTyACD0+MFjBaqWPAWXlFUgKFrj/LJmZ6fQQvFA0wYX9Z+YdDx7xP/wSzXM8J7jhI3Y
         cnv1opUi8bNDC5CGiUC5RyhE5sufSwg94ps4g0+w/MIT3GHEM+nHtCTD6yBD+zcjVMzC
         KM6SnUFC/LBhWAJoh5/3RAr1pEMN+dTTDdPPEWzL92kIaF0QNP3pX9QYFDhi6xIlcLq5
         xWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239511; x=1794844311;
        h=content-transfer-encoding:content-type:in-reply-to:from:to
         :content-language:references:cc:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GqcUVOE8YZm1FPDzDze4+rCKgn8rK0xiBVztztTok30=;
        b=wQdx73xGYE5v/c0p7gbvl26smj08qlQw7yhR/irlzZiGelG+9y3Ml98ErzSD1qMkoD
         IQUCuXrfhpdAfyqdwVE3+KpK81dvOMvgO0bR5R+7LNpVZ3M16SPc6El5fkXN+tEZabeb
         LkBGrrzuehqqAlIKok3pN2RzOrhTj9+dOvUcdN1n/9oc2ax/OTzfSCX3hyRu0LQqzAK5
         0ndRsJeNH4VL7kKk0bHAB+RCVbywarplkUu8i4uN7EwsKNsW1hrYlRSaYvW9n+Fu0nfQ
         1HRp/MA5uxktECtYxYlrjWgTCjNgHXfPU5PplcKcgdUCOVf0vv/LrUZ7HMbzrYxgLE3h
         eAMg==
X-Forwarded-Encrypted: i=1; AL+hErGE65QNPjVasWwZrksFSulGmM3FZdHCO0Lbzd2oneWm6MbTHa47UxwpkiyErgOL21550nMy9rGgqNc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+Sq13KNOqrc0E2S4k7kdtnnaOT8lPn3WtzmnvGtzAZGAMMXec
	+bx7o89GUFp9rqLqydKpdi7mnrLYQ18Nw7Nzxa4V+w5S/F3LE2FkM18Luwcb94/tFV0=
X-Gm-Gg: AYBFou1D68Ce++vzQzhQyoAUDgLZLyAI/SaONL1DPa6k7vuQLUNJ7ojF3vkqLHV5UZi
	zTNMOTSajzJFaoqugVkN8HiH6Im91xUE4ePUwnMtpoInChDlPRSSZgniIO7pw3+AE4XqsrumXHv
	cKHokD5+MuoJyGc3cf7PaT7vJrEu9t7c+Jadi0GFyL7VyGj+J5lEuG/aEpQTuVPn0HldCWDLWd/
	NBW73r24fohEsrkbGz2dUa8RQrUY+5BK+YqUDF09qvLHJn1baWACOtgcFJM4+tjw2YpyRZ4EwMR
	oP1ovCWRpCEeN05w0I4lmSVyRYL0GBBwduTWjuh1QtS+aJWH8yT4JqgYWjrypRWy84Gz+udr8Td
	AwqkgOg8XZ8kxN4D511Gm6+iavbxSw/nkbMKnavTksn1UnmRnazLEE3tU1xdfKVBbdiZVrOvoeb
	Rat4D1/y9T870O96XnJbAC50eqNCyoVw/JC9ukVSX/I2lZrjRySzsDJ7BzJqzbl+cHYAALFimcW
	7hehGdSoDpVagde3smRl7Wq/wkFa8tBR83KPDzV62DtrEsLn4/KSZCQODo3hPm3zfBkd2J4g0kl
	4hI7SOb/sMslJ+0Ln7ubdgocV0ivg9PftVO1Mt94UwhIxQHz3MhoIg1DqisjPO1+
X-Received: by 2002:a05:6000:25f5:b0:492:e1a6:90eb with SMTP id ffacd0b85a97d-49582e8e516mr8245452f8f.10.1794239511204;
        Mon, 09 Nov 2026 07:51:51 -0800 (PST)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597186eb9sm10435718f8f.35.2026.11.09.07.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 07:51:50 -0800 (PST)
Message-ID: <a190f981-d668-4208-8148-f4e50adb31a6@suse.com>
Date: Mon, 9 Nov 2026 16:51:48 +0100
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Remove obsolete __MODULE_STRING()
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rudolf Marek <r.marek@assembler.cz>, Andi Shyti <andi.shyti@kernel.org>,
 Chris Snook <chris.snook@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat
 <YehezkelShB@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Duncan Sands <duncan.sands@free.fr>,
 Chas Williams <3chas3@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
 <2e88806e-57dd-47e0-a9ef-a8507d22aa3e@suse.com>
Content-Language: en-US
To: Petr Pavlu <petr.pavlu@suse.com>
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <2e88806e-57dd-47e0-a9ef-a8507d22aa3e@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/26 11:36 AM, Petr Pavlu wrote:
> On 10/2/26 10:31 AM, Petr Pavlu wrote:
>> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
>> MODULE_PARM support for older modules" [1] in 2002-12. That change also
>> moved it to the graveyard section at the end of linux/module.h
>>
>> Replace the remaining uses of __MODULE_STRING() with __stringify() and
>> remove the macro.
>>
>> Apologies for the wide distribution. Acked-bys are appreciated.
>>
>> [1] https://git.kernel.org/tglx/history/c/136839a1b4
> 
> I've queued the second patch ("drivers: Replace __MODULE_STRING() with
> __stringify()") on modules-next for v7.4-rc1. Thanks for the Acked-byes
> and reviews.
> 
> The first patch ("hwmon: Replace __MODULE_STRING() with __stringify()")
> should go through the hwmon tree. Once these changes are in mainline,
> I plan to pick up the final patch ("module: Remove obsolete
> __MODULE_STRING()").

v7.4-rc1 no longer contains any __MODULE_STRING() calls, so I've queued
the final removal in patch 3 on modules-next for 7.5-rc1.

-- Petr
