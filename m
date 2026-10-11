Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830A1408026
	for <linux-rtc@vger.kernel.org>; Sun, 11 Oct 2026 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791715306; cv=none; b=UW7doXyzGh4io82kMXfIJEK09+E8c5vVYlSuHCjs0H3sUytm1CB3RZg8K7674GDHL1afs8raNYva2G6B/dGm3e3Cxoc3RQjWPfJS6/Bw+v78m19Pawjk79KOLvF7eIkTYBuMMl2jVdJnXQD5uDj/peG3a7g5pIttvGX7CFJ+pVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791715306; c=relaxed/simple;
	bh=qjhWHIzbLO2yDn9fEOpHiCs1+H596BfQIi5qxCi+tKw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RopZ+7MZmE5DuIJ458itttPrWWkEfT228EZGzYfHukuvgAbntNc8th6HdDLK9o7tsWNOk6hOF+603S9SZz0QL9XJ7kfD8Wkd65YrfpilLMLUSDDeXNDudjVUWB/OoOXg7cs+q3qYc6N4stY55Dr4qXEWPfi/6yumi+sH+OzAJk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mudrb7+D; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mudrb7+D"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a470ead068so815367a91.3
        for <linux-rtc@vger.kernel.org>; Sun, 11 Oct 2026 03:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791715305; x=1792320105; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qjhWHIzbLO2yDn9fEOpHiCs1+H596BfQIi5qxCi+tKw=;
        b=Mudrb7+DOVsx/WHdLb/Gl3lCHugOnk6XFxjjJKqOXvga5BUPv+7PAEAzBiMM9LkLmO
         I6awrpa1FGCUT8ls5cZzHM6e592sLMH6+/PPRO9cq55jp3Db7mnEPkwRCIxaAOqMrKqR
         cFRKTv5V+MQqIV0c81EmmLXLBpQCw9EYETwCEY4j+tTwGnQ9bWAy9TDdlz4Mnf0+ZE3d
         2h7HQe2WrdGc1Fx0FH2KkvMKEJuFRRgAbK1Jd80nwi+CXnMlWxJ69aghV5gDY3qE4907
         c6eCQpLd4kVPHcJECt1ABCG95PetXLcf/nV8BTfYzc2/ZkVNBWPUDvb4a0NZ+K2DNIP/
         pOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791715305; x=1792320105;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qjhWHIzbLO2yDn9fEOpHiCs1+H596BfQIi5qxCi+tKw=;
        b=WBdiRamiGV89/hgykHiuGgYIPCEUQYVKiN5UnJhW+S4wTJi9rbwXeFlMull2l2ZEZ2
         iPwwdZx0y6V6ywQ0/Lclt/J/inO+IKufzYs2Tyftm7kHlU8hd6/SI9XnPIx/A/CusFY1
         cUxcPE35RoxUZcqLbzLccrgTqGpkas2RTvZJFdABvY15BTONjYBUCc5MUN/vR0TFeFWK
         J6wrmMoRkyicihNHD/KTexl60zSRxe/Bxmvlmnv2QysvQ5QvoGHtYFhRvVvnPAKOBcHj
         sKXT5Db2iejTuJ7+vv7ajSnK4/Qzz0fQ4VtCY+YggxqB1vCp8hZkmgoMdvMbbVYYk3un
         BYpg==
X-Gm-Message-State: AFq9FYLHtAHZZvOKHhZSEvo7lclfueMDPwojF3d3QMADrBKJc9jz2CLb
	dmEsn4wWKMQYbC0xzREylzzZe4/LLwKVQ4h23DUBWXTl5efbhOhwXBCTmvbJGNeWow+8LgXcuID
	jWw==
X-Received: from pgbd17-n2.prod.google.com ([2002:a05:6a02:64d1:20b0:cc7:eb8b:50e3])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c8c:b0:3a4:967c:6947
 with SMTP id 98e67ed59e1d1-3ab3a99b4d0mr5011802a91.21.1791715304719; Sun, 11
 Oct 2026 03:41:44 -0700 (PDT)
Date: Sun, 11 Oct 2026 10:41:42 +0000
In-Reply-To: <20260910034821.2935214-1-wakel@google.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910034821.2935214-1-wakel@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261011104142.1225275-1-wakel@google.com>
Subject: Re: [PATCH] selftests: rtc: Support harness test filtering and arguments
From: Wake Liu <wakel@google.com>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Shuah,

Gentle ping on this patch. Alexandre has acked it from the RTC
side [1], and it still applies cleanly on top of both
kselftest/next and v7.3-rc6.

With this change, rtctest accepts the standard kselftest harness
options, so a test runner can select a subset of the cases with
e.g. "rtctest -t date_read -t date_read_loop". This would let
Android VTS drop a local #ifdef that it currently carries in
rtctest.c.

There is no rush; picking it up for the next cycle is perfectly
fine. Alexandre, if you would rather take it through the rtc tree,
that works for me as well.

FWIW, the pending date_read_loop fix [2] touches the same file.
The two patches are independent and apply in either order.

[1] https://lore.kernel.org/all/2026092119312953871857@mail.local/
[2] https://lore.kernel.org/all/20260929152212.2092062-1-wakel@google.com/

Thanks,
Wake
