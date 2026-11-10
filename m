Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794277973;
	b=ncTt5mxYqE4oKQJUSMdPC8MbnzfE4FIO68Iy5Cr9yNXp5BZK3s1J5k1KZ0EjDcq93RTL
	 FX1bYWteGpGVaikuu+VV4yLyPyd3J9vWW0k3i31G4MjxS1c2JMO9pgDqKUfvuy62Jwxak
	 K6be3+E3G8SPByiqmuSNi1WQqcyhovODApEOQ0/wLS6dFbUEX0OeiiujNdzW/ZYLgYDMG
	 etZWbAmSMj1wq5K9LNqMJnxzXculTwEJcxwqmtI14y/7pm90EMOgqCrgQOZ71LijYNxDX
	 EzKZZGYR3wIWWRPOibFlBXiO23PG5xl6oq9Mde2VMHUn3zBiYZOGzHgW47mPEvL2AQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794277973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=+UEXnv8sO59biXTVUGJWsxHSY+X/qyvekpO21DXG97s=;
	b=r6wTVraiUZ78YjH2I+keTn1eEsP6SKbTdSL7xQRSpyz5mNfzSKjQBsYr5kCrgFmAQgIZ
	 jPFceP6mGQTwjP/ytbH21Z9ImbkeQHuufRbgkGZhi67cIJDfODSdYjV0il0CBh2jVhXyb
	 sunhTI589CulsganzaVZbD6xQdiulOPl6qhYrw+2VkfKClOiqW5F9Q7P+/niYMZceL2XD
	 XzEw42QLr9yT91UcpqPoXgiuldTvhGkysu7KBGDdeQaWBn190kJAtHoGYrrCUYVGGxRSB
	 P0PqH5hY62YC+vypkRE4ioENUrJYQiF1Msj4EmBmnmtowO1ndu+JVBGKJdgzSV0Cakw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kN8usH9I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E1F606A321
	for <linux-rtc@vger.kernel.org>; Tue, 10 Nov 2026 02:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59E1F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kN8usH9I
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b587538a37so2189711a12.2
        for <linux-rtc@vger.kernel.org>; Mon, 09 Nov 2026 18:32:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794277972; cv=none;
        d=google.com; s=arc-20260327;
        b=ZCtt4soC1UesDydqEejbAU4DHIEOPMs6/nV3K2pEeHP946U0rLC5eqe97oQ+MCmz3A
         t9FZ6PJaOUcuxvvPtjiNuufPXOZ8oqeGmqolH2n/uKuQXrCSQGMaYw7Wrq08gkt4YNK0
         abDlbCXoTxSZ5JWG5t5PmzH14NN931KruUTjZyrvFd5oF8KVh5tTyOvl9FJK+mENz1KD
         yI7EZvwsOcPmG6bCfcTMhL8ydR+ZggRZr09ru8O/C1TYaCJZiBA83RU+nLHMnEu1Rhh3
         wAYazVfap/AqZNX2cCFBnQHstX9kgt9hNdCXYteBK73bKuDHAQDpJVlFLXDWkKV0e8xm
         unTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+UEXnv8sO59biXTVUGJWsxHSY+X/qyvekpO21DXG97s=;
        fh=qESVORFcck9JsUZxSdaEodeUNybMuD7cuhOBUJCKvzk=;
        b=XSZ0ePV1YOt3LsB5KLMVtVZahDXZTjFO0UW4sBlrRIB/YYNKJ140v4hwRUTCqqbIxR
         PHssU3SAzgkbvkmhHIKVSztUcUG5iGn4nZ8bvKaqfzMW9C0sPe3iuJkOCwVdI8BaRAZj
         Tl/1A9OXsPfkHzKqTelQVh1ScBut8tF/rHo4kHwNI6xylSw7Wz7eCnAAqvcUUfDfmbkW
         FxKadKu3WVlfdCtQKS2o/jDOF1Ns8WVQb955+iR5V6rRZ3JdF+0I+IyvtX/hUHd+SDKP
         U+vooIyCKouJbPZbEfjWiWVwK5AGzMa/VoyQp3VnoCAZ3Qgl6y+9EzU5HCPQR90FxMGW
         BnEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794277972; x=1794882772; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+UEXnv8sO59biXTVUGJWsxHSY+X/qyvekpO21DXG97s=;
        b=kN8usH9IU49ojTSFWxPbJVZ+ZPL9HfmyxBuwCulgrTZp/vIkQ2G69w6Y2yovNv946E
         bJzgBQHvSOFygF+KiU2KfzjtI0OAeGZi9VL3lKD+AvhAVGOQmot95xbnAbg2A4CaqsCf
         eTZ8KFJ96l3FwkAU/lwTHaXnrTtHfa2PYj99p6cQOQJSjiD4KSRMNhMDCcuyLBKNz9Os
         tSQbuty+GYOY4ZQ2vek1GcljQVgKSwQkRuubGXyLCTQolhUdTNTRmgmjxNwLUn2vfeXd
         12WP15h/MMthSPTaba6ldVBkatiFdKp89KUiyAAfiQLjEErfYKq0VKNkyG5HIpvzN859
         aeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794277972; x=1794882772;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+UEXnv8sO59biXTVUGJWsxHSY+X/qyvekpO21DXG97s=;
        b=p0rTmR6aE7aG4XmP9FGjYIryONKJmHV0ZwZarEnk7OZ++6CB0eufO0qDRQjQGeu+n9
         oJqJBJO2pNYQoS9zTWFC8fJbd00/xOmi2ZTO9PMf/6q+s09Hg1HJZ6g/1w4Yx5oKwx3j
         yussz9xo3H4DHfV/FbjKfLnnPAgUxv4/d6MpMz3KHecPIVMQs+ubvZ0eClM5JhS9NBer
         f0Hw0WuKwSV85ryDcgeMuwHktiXN0KLgofmrycWFP32aJxq8E9zhbPDl2NSzY3vvh3bA
         8T+K0sSDuYPTs7V3gTb5qUph4/ELCDZWeoc/rc5ODjLNJXB7IPtmQsRAxr1V1U2U9nyy
         0SPA==
X-Forwarded-Encrypted: i=1; AL+hErHMG5+5Y8DNSH+ZG2D2uFiEO7YFR+nX6NFn+VgpeWo4f2ZbV6JwRPhrK30p2cTpBWZ4UfKP0Nly0o4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TLpJLy/+bMlx8FA5EetvfGnaSc/oPlZCeZGJgBJVkZlq/lyjj
	iR9UTs0imHP3Du/dc5eWgmSVKBZtQnYyw5vJ0c6Ue35KsYVWNl++I1ga69ALihBsCF3dzo3/v1n
	x9Ebaxe4P4o7Yh0fxwfEhKM+ZJWYOgQ==
X-Gm-Gg: AYBFou0s9+CoWkZ78PxB3cxoZ5O41dbGHAPqsDn5tekl3PWoXtk0oVUZrbUU0VgcDM9
	04K83nRB0IE6c2kUnRBu8IMl+1aTbsp/fPvpvA2yYJxJ1zLMUeURtrf0P6k6ysRrKUQRW3QN+l9
	/kOpcJRGNOWJ0GF29KaIeR14C3B+gHHu1WDqQzpTsRAMBfXHqIqFHnzQZ/8DMqJFXXiaOXRGrQN
	Br8tYNr4TMyJMvL4GOGIZr+H8jfSlw+iHjoUVlELzSE+0lCt7jcyWMqSKOebDV9mQ3xf6zMODy6
	GuiPDUvASrA0TZ9x/ZWbXkyGZJ6L4a/VoQKHanHDCS9k7KdQAyO9244/0+4OaIWKIkt2LGwQ8qq
	Py0k6/ZQJDg8wNsnbP2iF2qX7Z4Y5olqeex+eZMZ1Uw/XENzbdp08LzV8vjZSWpxc0KdqbHWfuK
	lckw4rPDdIjI5Ku+BuFwdRO0hUVDiPF5pB1bpEr1jcL3YW
X-Received: by 2002:a05:6402:a507:10b0:6b1:8818:1090 with SMTP id
 4fb4d7f45d1cf-6b7568dc1e7mr684976a12.22.1794277971764; Mon, 09 Nov 2026
 18:32:51 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 10 Nov 2026 02:32:49 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Myeonghun Pak <mhun512@gmail.com>
Date: Tue, 10 Nov 2026 02:32:49 +0000
X-Gm-Features: AclHuK8AIkgNRXamUPSojUGsIPAwgEr26dHrd-qWTZA7kFbE804fLktH5iFVef4
Message-ID: <CAGEsz8Gb=4JS4OAFKppe=LW6JYa2ssJ8APdJJX2Ou_BhzEvZxg@mail.gmail.com>
Subject: [PATCH v2 0/2] mfd: wm831x: Fix IRQ mapping and cleanup
To: Lee Jones <lee@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, Ijae Kim <ae878000@gmail.com>, 
	patches@opensource.cirrus.com, mfd@lists.linux.dev, 
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Lee and Dmitry,

This series fixes WM831x IRQ resource mismatches and follows Dmitry's
request for managed onkey IRQ/work cleanup and MFD-provided mapped IRQs.
The provider and consumers are converted together to keep their IRQ
resources consistent.

Changes since v1:
- Use managed IRQ/work cleanup instead of storing the onkey IRQ.
- Move IRQ mapping into MFD and update all platform consumers.
- Reject failed mappings and unwind consumers before removing the domain.
- Retain polling for release detection; the chip only interrupts on assertion.
- Drop the previous Reviewed-by tag because the implementation changed
  substantially.

Compile-tested with LLVM, W=1 (arm64), for all 11 changed C objects.
No hardware testing.

Previous discussion:
https://lore.kernel.org/r/atJycIEnUZKVdTjW@google.com

Thanks,
Myeonghun
