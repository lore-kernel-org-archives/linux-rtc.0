Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B9D5505D0
	for <linux-rtc@vger.kernel.org>; Wed, 23 Sep 2026 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181973; cv=none; b=D1VmwXm/XJTAwke+gLfVEofBrJAeRS9gNxhObFsXENpCADyMnZC4ec720IZ7qpW5J5d/yFugGEprTxJyHmI304D9VycTraX/s9kLsH84aDQjpc3m5IV4k6wMNXzJoHTNhxUG7BzUkRVV5kWtOkhGMZZzsfT0hrVa96oFcM+4pvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181973; c=relaxed/simple;
	bh=2LlTo3wwPmeDQzltOkv+nInMpH0dQjqgS94fiJ0KCus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ES/OHRNCeAEbK30q1F0kPEyoT0VwEE0cIaUsrOWR9ti6VA+dbT95l+9MYDA5UMwAAaiwtaoFy1nPEVha83dyUcT5z4Ua5DUt36hboTRAQoFNEnIE34e6PqAKDvt3LKsgsxveb3d65XiY8XYAENsaxr9rry4TmE4Jf4wEBI7Qgug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jb8lTj6s; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jb8lTj6s"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49d097b4939so6425175e9.0
        for <linux-rtc@vger.kernel.org>; Wed, 23 Sep 2026 09:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790181961; x=1790786761; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jCRN4DHgD6jqSzbMa54UXzXSIZG4JDsooNiRjXbs5co=;
        b=jb8lTj6srvLoYdLZ8fgvRhF6IgsY0mLFQHujgE2MhNB98VI/iGpw8nFnsXOxJZ6EyG
         PCD9ATDKQz9UbTGRhcumGEBRga99HE5yYb9Nkn/TZdO8pT1M8uQ4pHfPR7BwqsetYp6/
         dfI8SV75SuEQc2ttQoeliZlOxEta8rntr3NGiiZktR1WdY92x8ayZrkAinGeGz8zAX/n
         YbjF2yv93mCFUUSm2ltnx6UliUDZiYbCNQ/UnC/p6nV3C0SQuubTWDKXV54Aol36UPJ6
         aY4pi2eQg5EWUZ88lc2u6tP8+7TY4VE7pIviHoQb7nW61REvmG73ERhpVts6UgyzXYNb
         Doug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790181961; x=1790786761;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jCRN4DHgD6jqSzbMa54UXzXSIZG4JDsooNiRjXbs5co=;
        b=Mu15+2IeQg44AVY1r19R7gngtzy2aB0jWOExRUG6BP3DXEJvHTcICKifz83xtQDNot
         z7t618cWgkH8yvQ+7s1dy82/oyrnOCKSmRvYdvkmwS4Y/9qRCqmgsf+SlebzLFt7VRT3
         JFTv7OagyiRregf/ENuFr97/ickyGf9nwOuyaZimemIHv+v0vzdSOmsdnQgsABtr4ljk
         SVwfvU6gx2v4/ztBaddNiY8VZ9X4QsyYANOzbtEPDm/yWeycGZ7x0TIBfvmguRdx7cV8
         iBXz6PC99+iBhqs+EH45PMNOru6CSlH4yzllZ7xlx0bcb22aotJt2a6OLiHBtugQnNEe
         ddBA==
X-Forwarded-Encrypted: i=1; AKwUvBz35Tyv4kA2sGCtFjW8s1EuE8XlcV5J09diCtTiV5wvDa/IabsjwphYY42iuL6AgIFp8yusaz5icWM=@vger.kernel.org
X-Gm-Message-State: AFuF++mVS0Iw2rpLdxwnI8aAs1eglGnEhe675y7ciyqnDVLAYv97kE9B
	3QCRfFlHa/o2Ix34ico+PEzY0Xz8Dqn1hq/6RjVJKDma4wmd0FWXHWzc
X-Gm-Gg: AYBFou31QW7EmJJnp5e9uHK9vai94Wlk1WB89TGhr/zPOYPh1kRWmVkpdRw0JP9Rn0G
	MOBz83KkTh+cg0FCbysGOIMxPQTREzAgp0kUQ5SxTMZw6KQ8s6uHDzr/KgdnwLybyswzf4ucji2
	qE0SE9ip2bngv0/3fWIckPg3ZzD/UU12cUIupx5/hK7OhLFARgQ/ZvlATKTFogdVJ8VabAfGq4f
	B1Wh/+Uj2ow84kB+dtnEtDnd0Lw9+GQ6miAbUcDEA+e8Gh4TrWEbXJS+CLP1AJ+ivoMuzKxk8ir
	f0jA11WAx4daH1nSDiVBpO5r/sos2nBy+wEoCVrBnivLzU5xGkwrofRj0kZWtXBiB/cCZcJkGfd
	TB5yNubyti+18R/C2sOsYEO7nEIvYQ9VGBfyXTsjST49gU0rP/2vCxGh+bGLKTDoosirt4qJCN0
	7+VoKklTu68P+cTtwA2pI34eET3/G/dDZbu2iJtEJrGvFjGpapbrIF4bdDjfN+iiPOjUmhu+yty
	5IkE2Rh7jDuBPbmPAd9MvhanIFA7OfaAurn8Rsg6kc=
X-Received: by 2002:a05:600c:3515:b0:49e:6861:50f7 with SMTP id 5b1f17b1804b1-49fdee0aa22mr49910965e9.5.1790181961405;
        Wed, 23 Sep 2026 09:46:01 -0700 (PDT)
Received: from [192.168.0.40] (212.71.14.70.adsl.dyn.edpnet.net. [212.71.14.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c104a6sm65685625e9.0.2026.09.23.09.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 09:46:00 -0700 (PDT)
Message-ID: <6de301bd-0bb6-4704-8c3f-8da09c5f6830@gmail.com>
Date: Wed, 23 Sep 2026 18:46:00 +0200
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: rtc: Add property for Raspberry Pi 5
 RTC
To: Conor Dooley <conor@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jonathan Bell <jonathan@raspberrypi.com>, Stefan Wahren <wahrenst@gmx.net>,
 linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20260923131323.1099979-1-sander.speetjens@gmail.com>
 <20260923131323.1099979-2-sander.speetjens@gmail.com>
 <20260923-browbeat-judgingly-b047721f5cb3@spud>
Content-Language: en-US
From: Sander Speetjens <sander.speetjens@gmail.com>
In-Reply-To: <20260923-browbeat-judgingly-b047721f5cb3@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Is this actually needed? Shouldn't the type of uint32 come from the same
> source that the type in rtc.yaml does? Or is this missing in dt-schema?

The rtc.yaml does only provide the description not the type, I also 
expected the type to be there.

